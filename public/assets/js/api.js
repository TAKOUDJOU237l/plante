/**
 * api.js - Wrapper générique pour appeler l'API REST PHP.
 * Toutes les pages du frontend passent par ces fonctions.
 */

const API_BASE = '/pharmacopee-platform/api';

async function apiRequest(endpoint, options = {}) {
  const response = await fetch(API_BASE + endpoint, {
    credentials: 'include',
    headers: { 'Content-Type': 'application/json' },
    ...options,
  });

  let data;
  try {
    data = await response.json();
  } catch (e) {
    throw new Error("Réponse invalide du serveur.");
  }

  if (!response.ok) {
    throw new Error(data.message || 'Erreur inconnue du serveur.');
  }
  return data;
}

const api = {
  get: (endpoint) => apiRequest(endpoint, { method: 'GET' }),
  post: (endpoint, body) => apiRequest(endpoint, { method: 'POST', body: JSON.stringify(body) }),
  put: (endpoint, body) => apiRequest(endpoint, { method: 'PUT', body: JSON.stringify(body) }),
  delete: (endpoint) => apiRequest(endpoint, { method: 'DELETE' }),
};

/**
 * Met à jour la barre de navigation selon l'état de connexion.
 * "Inscription" (déconnecté) et "Mon espace" (connecté) portent la classe
 * "primaire" pour être affichés comme le bouton d'action principal (pill vert).
 */
async function chargerEtatConnexion() {
  const zone = document.getElementById('nav-auth');
  if (!zone) return;

  try {
    const data = await api.get('/auth/me.php');
    if (data.connecte) {
      const lienDashboard =
        data.utilisateur.role === 'administrateur' ? 'dashboard-admin.html' :
        data.utilisateur.role === 'tradipraticien' ? 'dashboard-tradipraticien.html' : null;

      zone.innerHTML = `
        <span style="margin-right:4px;color:#374151;font-size:0.9rem;">Bonjour, ${data.utilisateur.nom}</span>
        ${lienDashboard ? `<a href="${lienDashboard}" class="primaire">Mon espace</a>` : ''}
        <button id="btn-deconnexion">Déconnexion</button>
      `;
      document.getElementById('btn-deconnexion').addEventListener('click', async () => {
        await api.post('/auth/logout.php', {});
        window.location.href = 'index.html';
      });
    } else {
      zone.innerHTML = `
        <a href="login.html">Connexion</a>
        <a href="register.html" class="primaire">Inscription</a>
      `;
    }
  } catch (e) {
    zone.innerHTML = `<a href="login.html">Connexion</a>`;
  }
}

document.addEventListener('DOMContentLoaded', chargerEtatConnexion);