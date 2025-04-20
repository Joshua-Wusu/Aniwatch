package com.aniwatch.aniwatch;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ProviderRepository extends JpaRepository<Provider, Long> {
    Optional<Provider> findByProviderId(Long providerId);
    Provider findByProviderUsername(String providerUsername);
    boolean existsByProviderUsername(String providerUsername);
    boolean existsByProviderEmail(String providerEmail);
}