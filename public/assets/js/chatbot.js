/**
 * chatbot.js - Widget de chat flottant présent sur toutes les pages publiques.
 * Envoie le message de l'utilisateur à /api/chatbot/analyse.php et affiche
 * les plantes suggérées en réponse (cf. maquette "Assistant Pharmacopée").
 */

function initChatbot() {
  const bulle = document.getElementById('chatbot-bulle');
  const fenetre = document.getElementById('chatbot-fenetre');
  const fermer = document.getElementById('chatbot-fermer');
  const zoneMessages = document.getElementById('chatbot-messages');
  const formSaisie = document.getElementById('chatbot-form');
  const inputMessage = document.getElementById('chatbot-input');

  if (!bulle) return; // widget absent de cette page

  bulle.addEventListener('click', () => fenetre.classList.toggle('ouvert'));
  fermer.addEventListener('click', () => fenetre.classList.remove('ouvert'));

  function ajouterMessage(texte, type = 'bot') {
    const div = document.createElement('div');
    div.className = 'message ' + type;
    div.textContent = texte;
    zoneMessages.appendChild(div);
    zoneMessages.scrollTop = zoneMessages.scrollHeight;
    return div;
  }

  function ajouterSuggestionsPlantes(plantes) {
    plantes.forEach((p) => {
      const div = document.createElement('div');
      div.className = 'message suggestion';
      div.innerHTML = `<strong>${p.nom_local}</strong><br><small>${p.preparation || ''}</small>`;
      div.addEventListener('click', () => {
        window.location.href = `plante.html?id=${p.id_plante}`;
      });
      zoneMessages.appendChild(div);
    });
    zoneMessages.scrollTop = zoneMessages.scrollHeight;
  }

  // Message d'accueil
  ajouterMessage('Bonjour ! Décrivez-moi vos symptômes (ex : "maux de ventre, fièvre").');

  formSaisie.addEventListener('submit', async (e) => {
    e.preventDefault();
    const texte = inputMessage.value.trim();
    if (!texte) return;

    ajouterMessage(texte, 'user');
    inputMessage.value = '';

    const chargement = ajouterMessage('...', 'bot');

    try {
      const data = await api.post('/chatbot/analyse.php', { symptomes: texte });
      chargement.remove();

      if (data.reponse) {
        ajouterMessage(data.reponse);
      }

      if (data.plantes && data.plantes.length > 0) {
        if (!data.reponse) {
          ajouterMessage(`Voici ${data.plantes.length} plante(s) traditionnellement utilisée(s) pour ces symptômes :`);
        }
        ajouterSuggestionsPlantes(data.plantes);
      } else {
        if (!data.reponse) {
          ajouterMessage("Je n'ai trouvé aucune plante correspondant à ces symptômes. Essayez de reformuler ou consultez un tradipraticien.");
        }
      }
    } catch (err) {
      chargement.remove();
      ajouterMessage("Une erreur est survenue. Veuillez réessayer.");
    }
  });
}

document.addEventListener('DOMContentLoaded', initChatbot);
