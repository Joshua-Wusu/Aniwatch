document.getElementById('searchInput').addEventListener('input', function () {
    const searchTerm = this.value.toLowerCase();
    const watchlistItems = document.querySelectorAll('.watchlist-item');

    watchlistItems.forEach(item => {
        const title = item.querySelector('.card-title').textContent.toLowerCase();
        const description = item.querySelector('.card-text:not(.mb-0)').textContent.toLowerCase();
        const keywords = item.getAttribute('data-keywords').toLowerCase();

        if (title.includes(searchTerm) || description.includes(searchTerm) || keywords.includes(searchTerm)) {
            item.style.display = 'block';
        } else {
            item.style.display = 'none';
        }
    });
});  
