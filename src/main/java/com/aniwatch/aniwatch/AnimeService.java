package com.aniwatch.aniwatch;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnimeService {

    @Autowired
    private AnimeRepository animeRepository;

    public List<Anime> getAllAnime() {
        return animeRepository.findAll();
    }

    public Anime getAnimeById(Long id) {
        return animeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Anime not found with id: " + id));
    }

    // Placeholder for sample data, I gave up lol
    public void initializeSampleData() {
        if (animeRepository.count() == 0) {
            createSampleAnime("Solo Leveling", "Ore dake Level Up na Ken", "/pics/Solo-Leveling.jpg");
            createSampleAnime("The Apothecary Diaries", "Kusuriya no Hitorigoto", "/pics/The-Apothecary-Diaries.jpg");
            createSampleAnime("One Piece", "One Piece", "/pics/One-Piece.jpg");
            createSampleAnime("Re:ZERO - Starting Life in Another World", "Re:Zero kara Hajimeru Isekai Seikatsu", "/pics/ReZero.jpg");
            createSampleAnime("Orb: On the Movements of the Earth", "Chi. Chikyuu no Undou ni Tsuite", "/pics/Orb.jpg");
            createSampleAnime("Shangri-La Frontier", "Shangri-La Frontier: Kusoge Hunter, Kamige ni Idoman to su", "/pics/Shangri-La-Frontier.jpg");
            createSampleAnime("Dr. Stone", "Dr. Stone: Science Future", "/pics/Dr.Stone.jpg");
        }
    }

    private void createSampleAnime(String title, String alternateTitle, String imageUrl) {
        Anime anime = new Anime();
        anime.setTitle(title);
        anime.setAlternateTitle(alternateTitle);
        anime.setImageUrl(imageUrl);
        animeRepository.save(anime);
    }
}