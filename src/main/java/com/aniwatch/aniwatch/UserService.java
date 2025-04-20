package com.aniwatch.aniwatch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashSet;
import java.util.Optional;
import java.util.Set;
import java.util.UUID;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProviderRepository providerRepository;

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private ProviderService providerService;

    @Transactional
    public User registerProviderUser(String username, String password, Long providerId) {
        try {
            // Check if the username already exists
            if (userRepository.findByUsername(username).isPresent()) {
                throw new RuntimeException("Username already exists: " + username);
            }

            // Verify the provider exists
            boolean providerExists = providerRepository.findByProviderId(providerId).isPresent();
            if (!providerExists) {
                throw new RuntimeException("Provider not found with ID: " + providerId);
            }

            User user = new User();
            user.setUsername(username);
            user.setPassword(passwordEncoder.encode(password));
            user.setEnabled(true);
            user.setProviderId(providerId);

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            user.setJoinDate(LocalDateTime.now().format(formatter));

            Set<String> roles = new HashSet<>();
            roles.add("PROVIDER");
            user.setRoles(roles);

            User savedUser = userRepository.save(user);
            System.out.println("Provider user saved: " + savedUser.getId() + " - " + savedUser.getUsername());
            return savedUser;
        } catch (Exception e) {
            System.err.println("Error registering provider user: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    @Transactional
    public User registerRegularUser(String username, String password) {
        try {
            if (userRepository.findByUsername(username).isPresent()) {
                throw new RuntimeException("Username already exists: " + username);
            }

            User user = new User();
            user.setUsername(username);
            user.setPassword(passwordEncoder.encode(password));
            user.setEnabled(true);

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            user.setJoinDate(LocalDateTime.now().format(formatter));

            user.setProfileImage("/pics/default-profile.jpg");

            Set<String> roles = new HashSet<>();
            roles.add("USER");
            user.setRoles(roles);

            User savedUser = userRepository.save(user);
            System.out.println("Regular user saved: " + savedUser.getId() + " - " + savedUser.getUsername());
            return savedUser;
        } catch (Exception e) {
            System.err.println("Error registering regular user: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

    public Optional<User> findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public boolean isProvider(String username) {
        return userRepository.findByUsername(username)
                .map(user -> user.hasRole("PROVIDER"))
                .orElse(false);
    }

    public Long getProviderId(String username) {
        return userRepository.findByUsername(username)
                .map(User::getProviderId)
                .orElse(null);
    }

    public Provider getProviderById(Long providerId) {
        return providerRepository.findByProviderId(providerId)
                .orElseThrow(() -> new RuntimeException("Provider not found with ID: " + providerId));
    }

    @Transactional
    public void updateUserProfile(String username, String bio, MultipartFile profileImage) {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));

        if (bio != null) {
            user.setBio(bio);
        }

        if (profileImage != null && !profileImage.isEmpty()) {
            String imagePath = saveProfileImage(profileImage);
            user.setProfileImage(imagePath);
        }

        userRepository.save(user);
    }

    public Optional<User> findById(Long userId) {
        return userRepository.findById(userId);
    }

    public User saveUser(User user) {
        return userRepository.save(user);
    }

    private String saveProfileImage(MultipartFile file) {
        try {
            String uploadDir = System.getProperty("user.dir") + "/src/main/resources/static/uploads/profiles";
            Path uploadPath = Paths.get(uploadDir);

            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            String filename = UUID.randomUUID().toString() + "_" +
                    file.getOriginalFilename().replaceAll("\\s+", "_");
            Path filePath = uploadPath.resolve(filename);

            Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

            return "/uploads/profiles/" + filename;
        } catch (IOException e) {
            throw new RuntimeException("Failed to save profile image", e);
        }
    }

    public String getCurrentUserAvatar(String username) {
        return findByUsername(username)
                .map(user -> {
                    if (user.hasRole("PROVIDER")) {
                        // If user is a provider, get provider profile image
                        Long providerId = user.getProviderId();
                        if (providerId != null) {
                            try {
                                Provider provider = providerService.getProviderByProviderId(providerId);
                                return provider.getProviderProfileImage();
                            } catch (Exception e) {
                                // Fallback to user profile image if provider not found
                                return user.getProfileImage() != null ?
                                        user.getProfileImage() : "/pics/default-profile.jpg";
                            }
                        }
                    }
                    // Return user profile image for regular users
                    return user.getProfileImage() != null ?
                            user.getProfileImage() : "/pics/default-profile.jpg";
                })
                .orElse("/pics/default-profile.jpg");
    }

    public int countUserComments(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with ID: " + userId));

        return commentRepository.countByUsername(user.getUsername());
    }

    public ProviderStats calculateProviderStats(Long providerId) {
        return providerService.calculateProviderStats(providerId);
    }
}