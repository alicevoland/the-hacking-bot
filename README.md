# The Hacking Bot

## Présentation


Création d'un bot Discord pour les moussaillons de [The Hacking Project](https://www.thehackingproject.org/), asocié à un site Rails.

Un tutoriel sur la création d'un bot Discord avec la [gem discordrb](https://github.com/discordrb/discordrb) est disponible ici : [thp-tutoriel-bot-discord](https://github.com/mvoland/thp-tutoriel-bot-discord).

Le site est mis en ligne sur heroku : [the-hacking-bot.herokuapp.com](https://the-hacking-bot.herokuapp.com/).

## Inscription

L'inscription se fait en deux étapes. Une première étape sur le site [the-hacking-bot.herokuapp.com/users/sign_up](https://the-hacking-bot.herokuapp.com/users/sign_up) avec un mail et un mot de passe (gem devise). Et ensuite pour "lier" son compte discord il faut envoyer une commande au bot, du type `$verify email token`.

 1. Créer un compte : [the-hacking-bot.herokuapp.com/users/sign_up](https://the-hacking-bot.herokuapp.com/users/sign_up)
 2. Aller sur la page "Mon compte" [the-hacking-bot.herokuapp.com/profile](https://the-hacking-bot.herokuapp.com/profile)
 3. Cliquer sur le bouton "Lier mon compte Discord" et copier ce qui apparait `$verify test@yopmail.com lbKfw5t+xO5p5g==`
 4. Aller parler à The Hacking Bot en message privé, ou bien sur le channel DRAFT/bots
 5. Et voilà, la liste des commandes est disponible en tapant `$help`

## Fonctionnement

Une commande `$help` permet d'afficher les commandes disponibles :
```
Liste des commandes
----------------------------------------------------------------------------------------------------
$$COMMAND    ARGS                          : DESCRIPTION
$verify      EMAIL TOKEN                   : Pour lier le compte Discord à The Hacking Bot
$status      STATUS                        : Au choix need_help, can_help, work_in_progress
$wip                                       : raccourci pour $status _work_in_progress
$can_help                                  : raccourci pour $status can_help
$need_help                                 : raccourci pour $status need_help
$mood        ton humeur, une petite phrase : Bloqué sur :&#!!?
$visibility  TRUE|FALSE                    : Au choix true ou false
$visible                                   : raccourci pour $visibility true
$unvisible                                 : raccourci pour $visibility false
$mention     STATUS                        : Mentionne les utilisateurs visibles et avec statut=SATUS
----------------------------------------------------------------------------------------------------
-- A bientôt sur : https://the-hacking-bot.herokuapp.com/
```

Assez peu de fonctionnalités pour le moment. On peut voir le statut des personnes qui souhaite le rendre public sur la page "Tous les membres" : [the-hacking-bot.herokuapp.com/users](https://the-hacking-bot.herokuapp.com/users).

On peut choisir d'avoir un statut visible ou invisible :
 * `$visible`
 * `$unvisible`

On peut choisir d'ajouter un "mood" qui apparait avec le statut si on a choisi visible :
 * `$mood problème avec sendgrid.... HELP`

On peut définir son statut qui apparait donc uniquement si on a choisi visible :
 * `$wip` (statut neutre - work in progress)
 * `$can_help`
 * `$need_help`

Enfin on peut demander au bot de mentionner des personnes (parmi celles "visibles" donc) selon leur statut :
 * `$mention can_help`
 * `$mention need_help`
 * `$mention wip`

## Pour la suite

L'idée est ensuite de laisser le bot mettre directement en relation les personnes, éventuellement pouvoir indiquer sur quel point on a besoin d'aide, et proposer une vrai page personnelle par utilisateur, etc.

Je cherche d'abord des retours sur :

 * Est-ce que ça peut être utile ?
 * Qu'est ce qu'il faudrait améliorer ?
 * Qu'est ce qui peut poser problème (le fait d'être affiché sur une page publique par exemple ?)

Merci pour tout retour ! => L'idéal est de créer un "Issue" dans ce projet GitHub
