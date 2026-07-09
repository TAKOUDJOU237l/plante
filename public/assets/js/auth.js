/**
 * auth.js - Gère la soumission des formulaires login.html et register.html.
 */

function afficherErreur(idBloc, texte) {
  const bloc = document.getElementById(idBloc);
  if (!bloc) return;
  bloc.textContent = texte;
  bloc.style.display = 'block';
}

function masquerMessages(...ids) {
  ids.forEach((id) => {
    const el = document.getElementById(id);
    if (el) el.style.display = 'none';
  });
}

document.addEventListener('DOMContentLoaded', () => {
  // ---------- Bascule afficher/masquer mot de passe ----------
  document.querySelectorAll('.bouton-afficher-mdp').forEach((bouton) => {
    bouton.addEventListener('click', () => {
      const champ = document.getElementById(bouton.dataset.cible);
      if (!champ) return;
      const estMasque = champ.type === 'password';
      champ.type = estMasque ? 'text' : 'password';
      bouton.textContent = estMasque ? '🙈' : '👁';
      bouton.setAttribute('aria-label', estMasque ? 'Masquer le mot de passe' : 'Afficher le mot de passe');
    });
  });

  // ---------- Formulaire de connexion ----------
  const formLogin = document.getElementById('form-login');
  if (formLogin) {
    formLogin.addEventListener('submit', async (e) => {
      e.preventDefault();
      masquerMessages('erreur-login');

      const email = document.getElementById('email').value.trim();
      const mot_passe = document.getElementById('mot_passe').value;

      try {
        const data = await api.post('/auth/login.php', { email, mot_passe });
        const role = data.utilisateur.role;
        if (role === 'administrateur') window.location.href = 'dashboard-admin.html';
        else if (role === 'tradipraticien') window.location.href = 'dashboard-tradipraticien.html';
        else window.location.href = 'index.html';
      } catch (err) {
        afficherErreur('erreur-login', err.message);
      }
    });
  }

  // ---------- Formulaire d'inscription ----------
  const formRegister = document.getElementById('form-register');
  if (formRegister) {
    const selectRole = document.getElementById('role');
    const champInstitution = document.getElementById('bloc-institution');

    if (selectRole && champInstitution) {
      selectRole.addEventListener('change', () => {
        champInstitution.style.display = selectRole.value === 'chercheur' ? 'block' : 'none';
      });
    }

    formRegister.addEventListener('submit', async (e) => {
      e.preventDefault();
      masquerMessages('erreur-register', 'succes-register');

      const nom = document.getElementById('nom').value.trim();
      const email = document.getElementById('email').value.trim();
      const mot_passe = document.getElementById('mot_passe').value;
      const role = document.getElementById('role').value;
      const institution = document.getElementById('institution')
        ? document.getElementById('institution').value.trim()
        : '';

      try {
        await api.post('/auth/register.php', { nom, email, mot_passe, role, institution });
        document.getElementById('succes-register').textContent =
          'Compte créé avec succès ! Redirection vers la connexion...';
        document.getElementById('succes-register').style.display = 'block';
        setTimeout(() => (window.location.href = 'login.html'), 1800);
      } catch (err) {
        afficherErreur('erreur-register', err.message);
      }
    });
  }
});