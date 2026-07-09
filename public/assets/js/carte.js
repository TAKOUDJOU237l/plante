/**
 * carte.js - Initialise la carte interactive Leaflet et affiche les
 * tradipraticiens validés, avec filtres ethnie / région / spécialité.
 * Nécessite Leaflet (CSS + JS) chargé depuis unpkg dans la page HTML.
 */

let carteLeaflet = null;
let couchesMarqueurs = [];

function initCarte(idConteneur = 'carte-interactive') {
  const conteneur = document.getElementById(idConteneur);
  if (!conteneur || typeof L === 'undefined') return;

  // Centrage par défaut sur le Cameroun
  carteLeaflet = L.map(idConteneur).setView([5.6, 12.0], 6.3);

  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; OpenStreetMap contributors',
    maxZoom: 18,
  }).addTo(carteLeaflet);

  chargerTradipraticiens();
}

async function chargerTradipraticiens(filtres = {}) {
  if (!carteLeaflet) return;

  // Nettoie les anciens marqueurs
  couchesMarqueurs.forEach((m) => carteLeaflet.removeLayer(m));
  couchesMarqueurs = [];

  const params = new URLSearchParams(filtres).toString();
  try {
    const data = await api.get('/tradipraticiens/list.php' + (params ? '?' + params : ''));

    data.tradipraticiens.forEach((t) => {
      if (!t.latitude || !t.longitude) return;
      const marqueur = L.marker([t.latitude, t.longitude]).addTo(carteLeaflet);
      marqueur.bindPopup(`
        <strong>${t.nom}</strong><br>
        ${t.specialites || 'Spécialité non renseignée'}<br>
        <small>Disponibilités : ${t.disponibilites || 'N/A'}</small>
      `);
      couchesMarqueurs.push(marqueur);
    });

    const listeHtml = document.getElementById('liste-tradipraticiens');
    if (listeHtml) {
      listeHtml.innerHTML = data.tradipraticiens.map((t) => `
        <div class="carte-tradi">
          <h4>${t.nom}</h4>
          <p>${t.specialites || 'Spécialité non renseignée'}</p>
          <span class="statut">Validé</span>
        </div>
      `).join('') || '<p>Aucun tradipraticien trouvé pour ces critères.</p>';
    }
  } catch (e) {
    console.error('Erreur chargement tradipraticiens :', e);
  }
}

// Branche les filtres si présents sur la page (fiche plante / carte.html)
document.addEventListener('DOMContentLoaded', () => {
  initCarte();

  const selectEthnie = document.getElementById('filtre-ethnie');
  const selectRegion = document.getElementById('filtre-region');

  function appliquerFiltres() {
    chargerTradipraticiens({
      ethnie: selectEthnie ? selectEthnie.value : '',
      region: selectRegion ? selectRegion.value : '',
    });
  }

  if (selectEthnie) selectEthnie.addEventListener('change', appliquerFiltres);
  if (selectRegion) selectRegion.addEventListener('change', appliquerFiltres);
});
