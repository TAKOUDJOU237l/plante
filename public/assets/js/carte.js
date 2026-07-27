/**
 * carte.js - Initialise la carte interactive Leaflet et affiche les
 * tradipraticiens validés du Cameroun avec leurs fiches détaillées,
 * filtres ethnie / région / ville / spécialité.
 */

let carteLeaflet = null;
let couchesMarqueurs = [];

function initCarte(idConteneur = 'carte-interactive') {
  const conteneur = document.getElementById(idConteneur);
  if (!conteneur || typeof L === 'undefined') return;

  // Centrage par défaut sur le Cameroun (Bafoussam/Yaoundé)
  carteLeaflet = L.map(idConteneur).setView([5.2, 11.5], 6.5);

  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; OpenStreetMap contributors | Pharmacopée Camerounaise',
    maxZoom: 18,
  }).addTo(carteLeaflet);

  chargerTradipraticiens();
}

async function chargerTradipraticiens(filtres = {}) {
  if (!carteLeaflet) return;

  // Nettoie les anciens marqueurs
  couchesMarqueurs.forEach((m) => carteLeaflet.removeLayer(m));
  couchesMarqueurs = [];

  const queryParams = new URLSearchParams(filtres).toString();
  try {
    const data = await api.get('/tradipraticiens/list.php' + (queryParams ? '?' + queryParams : ''));

    data.tradipraticiens.forEach((t) => {
      if (!t.latitude || !t.longitude) return;
      const marqueur = L.marker([t.latitude, t.longitude]).addTo(carteLeaflet);

      const telSanitized = t.telephone ? t.telephone.replace(/\s+/g, '') : '';
      const whatsappUrl = telSanitized ? `https://wa.me/${telSanitized.replace('+', '')}` : '#';

      const popupHtml = `
        <div style="font-family: system-ui, sans-serif; max-width: 260px; line-height: 1.4;">
          <div style="font-size: 11px; font-weight: 700; text-transform: uppercase; color: #166534; margin-bottom: 2px;">
            🌿 ${t.titre || 'Tradi-praticien agréé'}
          </div>
          <h3 style="margin: 0 0 4px 0; font-size: 15px; color: #111827; font-weight: 700;">${t.nom}</h3>
          <div style="font-size: 12px; color: #4b5563; margin-bottom: 6px;">
            📍 <strong>${t.ville || 'Cameroun'}</strong> ${t.adresse ? '— ' + t.adresse : ''}
          </div>
          <div style="font-size: 12px; background: #f0fdf4; border-left: 3px solid #22c55e; padding: 4px 6px; margin-bottom: 6px; border-radius: 4px;">
            ⭐ <strong>${t.annees_experience || 0} ans d'expérience</strong><br>
            📜 <small>${t.numero_accreditation || 'Certifié MINSANTE'}</small>
          </div>
          <div style="font-size: 12px; color: #374151; margin-bottom: 8px;">
            ⚡ <em>${t.specialites || 'Phytothérapie'}</em>
          </div>
          ${t.telephone ? `
            <a href="tel:${telSanitized}" style="display: inline-block; background: #15803d; color: white; padding: 5px 10px; border-radius: 4px; text-decoration: none; font-size: 12px; font-weight: 600; margin-right: 4px;">
              📞 Appeler (${t.telephone})
            </a>
          ` : ''}
        </div>
      `;

      marqueur.bindPopup(popupHtml);
      couchesMarqueurs.push(marqueur);
    });

    const listeHtml = document.getElementById('liste-tradipraticiens');
    if (listeHtml) {
      if (!data.tradipraticiens || data.tradipraticiens.length === 0) {
        listeHtml.innerHTML = '<p style="grid-column: 1/-1; text-align: center; color: #6b7280; padding: 2rem;">Aucun tradipraticien trouvé pour ces critères.</p>';
      } else {
        listeHtml.innerHTML = data.tradipraticiens.map((t) => {
          const telSanitized = t.telephone ? t.telephone.replace(/\s+/g, '') : '';
          return `
            <div class="carte-tradi" style="background: white; border-radius: 8px; border: 1px solid #e5e7eb; padding: 1.25rem; box-shadow: 0 1px 3px rgba(0,0,0,0.1); transition: transform 0.2s, box-shadow 0.2s;">
              <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 0.5rem;">
                <span style="display: inline-block; background: #dcfce7; color: #15803d; font-size: 0.75rem; font-weight: 700; padding: 2px 8px; border-radius: 9999px;">
                  ✓ ${t.statut_validation === 'valide' ? 'Agrée MINSANTE' : 'En attente'}
                </span>
                <span style="font-size: 0.8rem; color: #6b7280;">📍 ${t.ville || 'Cameroun'}</span>
              </div>
              <h4 style="margin: 0 0 0.25rem 0; font-size: 1.1rem; color: #111827;">${t.nom}</h4>
              <p style="font-size: 0.85rem; color: #166534; font-weight: 600; margin: 0 0 0.5rem 0;">${t.titre || 'Tradi-praticien'}</p>
              <p style="font-size: 0.9rem; color: #4b5563; margin-bottom: 0.75rem; line-height: 1.4;">
                ${t.biographie ? t.biographie.substring(0, 110) + '...' : (t.specialites || 'Phytothérapie')}
              </p>
              <div style="font-size: 0.8rem; color: #374151; background: #f9fafb; padding: 0.5rem; border-radius: 6px; margin-bottom: 0.75rem;">
                📞 <strong>${t.telephone || 'Contact sur place'}</strong><br>
                🕒 ${t.disponibilites || 'Lun - Sam'} | 🏆 ${t.annees_experience || 0} ans d'exp.
              </div>
              ${t.telephone ? `
                <a href="tel:${telSanitized}" style="display: block; text-align: center; background: #15803d; color: white; padding: 0.5rem; border-radius: 6px; text-decoration: none; font-weight: 600; font-size: 0.9rem;">
                  Contacter le tradipraticien
                </a>
              ` : ''}
            </div>
          `;
        }).join('');
      }
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

