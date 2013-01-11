#!/usr/bin/perl

use strict;
use warnings;

use IPC::Run3;
use Test::More tests => 42;

my $expected_code;
my $expected_string;
my $expected_error;
my $return_code;
my $return_string;
my $return_error;

my $home;

use ScriptCooker::Utils;
source_profile('t/sample/profile.RT.minimal');

##################
# echo "" | Formate_File -
##################

$expected_code = 0;
$expected_string = <<'EXPECTED_OUTPUT';


EXPECTED_OUTPUT
chomp $expected_string;
$expected_error = << 'EXPECTED_ERRSTD';

EXPECTED_ERRSTD
chomp $expected_error;

run3('echo "" | Formate_File -', undef, \$return_string, \$return_error);

$home=quotemeta($ENV{TOOLS_HOME});
$return_string =~ s/$home/TOOLS_HOME/g;
$return_error =~ s/$home/TOOLS_HOME/g;

if ( $? == -1 ) {
	BAIL_OUT("<".'echo "" | Formate_File -'."> retourne -1");
}
$return_code = $? >> 8;

is ( $return_code ,$expected_code , "<".'echo "" | Formate_File -'."> return code $expected_code");
is ( $return_string ,$expected_string , "<".'echo "" | Formate_File -'."> output <".q{}.">");

# test si a renvoyer une erreur ou non
is ( $return_error ne '', $expected_error ne '', "<".'echo "" | Formate_File -'."> errstd") or diag($return_error);


##################
# Select -s from error_messages | Formate_File -
##################

$expected_code = 0;
$expected_string = <<'EXPECTED_OUTPUT';
TEST;1;test sans quote
TEST;2;test avec ' des ' quote
TEST;3;test avec " des " double quote
TEST;4;test avec \" des \' quote echappees
TEST;5;test avec \\ echappements \n
TEST;6;test avec trop de ; separ;ateurs;
TEST;7;test avec des $variables $TESTVAR
TEST;8;test avec des $variables $(echo "commande evaluee")
TEST;9;test avec des $variables `echo "commande evaluee"`
TEST_${TESTVAR};0;test avec des une clef contenant une variable
Check;65;Non unicite de la clef
Insert;8;La condition de selection de cle n'est pas valide
Insert;97;Aucune valeur a inserer n'est specifiee
Modify;8;La condition de selection de la cle n est pas valide
Modify;68;Aucune ligne trouvee a modifier
Modify;97;Aucune valeur a modifier n'est specifiee
Remove;68;Aucune ligne trouvee a supprimer
Replace;8;La condition de selection de la cle n'est pas valide
Replace;68;Aucune ligne trouvee a remplacer
Replace;97;Aucune valeur a remplacer n'est specifiee
generic;1;Impossible de trouver l'executable %s
generic;2;Impossible de trouver la table %s
generic;3;Impossible de trouver ou d'ouvrir le fichier de definition %s
generic;4;Impossible de trouver le fichier %s
generic;5;Le fichier de definition %s n'est pas valide
generic;6;La table %s est une table virtuelle
generic;7;La colonne %s n'existe pas
generic;8;La condition de selection n'est pas valide
generic;9;La chaine de definition %s n'est pas valide ou est absente
generic;10;Impossible d'ouvrir le fichier %s
generic;11;Impossible d'ecrire dans le fichier %s
generic;12;Impossible de supprimer le fichier %s
generic;13;Impossible de changer les droits sur le fichier %s
generic;14;Impossible de renommer/deplacer le fichier %s en %s
generic;15;Impossible de copier le fichier %s
generic;16;Erreur lors d'une ecriture dans le fichier %s
generic;17;La commande <%s> a echoue
generic;18;La variable racine BV_HOME ou TOOLS_HOME n'est pas exportee !
generic;19;L'evaluation de <%s> est incorrecte !
generic;20;L'option %s n'est pas valide
generic;21;Le nombre d'arguments est incorrect
generic;22;L'argument %s n'est pas valide
generic;23;Utilisation incorrecte de l'option -h
generic;24;Ligne de commande incorrecte
generic;25;Erreur lors d'une allocation de memoire %s
generic;26;Erreur lors d'une re-allocation de memoire %s
generic;27;Erreur lors du chargement de la librairie %s !
generic;28;Impossible de retrouver le symbole %s en librairie !
generic;29;Erreur lors de la fermeture de la librairie %s !
generic;30;Votre licence d'utilisation %s a expire !
generic;31;Le Hostid de la machine n'est pas valide !
generic;32;La licence n'est pas valide !
generic;33;Il n'y a pas de licence valide pour ce produit !
generic;34;Le nombre de clients pour ce produit est depasse !
generic;35;Le nom de fichier %s n'est pas valide
generic;36;Le fichier %s est verouille
generic;37;Impossible de poser un verrou sur le fichier %s
generic;38;Le delai maximum d'attente de deverouillage a ete atteint
generic;39;Le fichier %s n'est pas verouille
generic;40;Impossible de retirer le verrou du fichier %s
generic;41;Le nombre maximal de selections simultanees est depasse
generic;42;Le Handle d'une requete n'est pas valide
generic;43;Le nombre maximal de conditions est depasse
generic;44;Impossible de retrouver la librairie %s !
generic;45;Un Handle n'est pas valide
generic;46;Le nombre maximal de fichiers ouverts est depasse
generic;47;Le nombre maximal %s d'allocations de memoire est depasse
generic;48;Impossible de retrouver le fichier de menu %s
generic;49;Impossible de retrouver le dictionnaire graphique %s
generic;50;Erreur lors de l'execution de la fonction de log
generic;51;Erreur de type '%s' lors de la deconnexion Oracle !
generic;52;Impossible d'ecrire dans le fichier log %s
generic;53;Impossible de determiner le nom du traitement
generic;54;Le numero d'erreur est manquant
generic;55;Le message d'information est manquant
generic;56;Le numero d'erreur %s n'a pas de message associe
generic;57;Le numero d'erreur %s n'est pas correct
generic;58;Le type de message de log n'est pas correct
generic;59;Le nom de table %s n'est pas valide
generic;60;La colonne %s doit absolument contenir une valeur
generic;61;Il n'y a pas assez de valeurs par rapport au nombre de colonnes
generic;62;Il y a trop de valeurs par rapport au nombre de colonnes
generic;63;La valeur donnee pour la colonne %s n'est pas correcte.
generic;64;Le nom de la table n'est pas specifie
generic;65;Non unicite de la clef de la ligne a inserer
generic;66;Le groupe d'utilisateurs %s n'existe pas
generic;67;Impossible de remplacer une ligne sur une table sans clef
generic;68;Aucune ligne trouvee
generic;69;Entete de definition invalide !
generic;70;Variables d'environnement SEP ou FORMAT absente !
generic;71;Il n'y a pas de lignes en entree stdin !
generic;72;Impossible d'ouvrir le fichier %s en ecriture !
generic;73;Impossible d'ouvrir le fichier %s en lecture !
generic;74;Impossible d'ouvrir le fichier %s en lecture et ecriture !
generic;75;Erreur generique Oracle : %s
generic;76;Erreur de syntaxe dans la requete SQL generee : %s
generic;77;Une valeur a inserer est trop large pour sa colonne !
generic;78;Impossible de se connecter a Oracle avec l'utilisateur %s
generic;79;Impossible de locker la table %s. Ressource deja occupee !
generic;80;La requete interne SQL s'est terminee en erreur !
generic;81;Le nouveau separateur n'est pas specifie !
generic;82;Le nombre maximal de colonnes %s du dictionnaire est depasse !
generic;83;La colonne %s apparait plusieurs fois dans le dictionnaire !
generic;84;La source de donnees %s du dictionnaire est invalide !
generic;85;La table %s ne peut-etre verouillee ou deverouillee !
generic;86;Vous ne pouvez pas remplacer une cle !
generic;87;Impossible de creer un nouveau processus %s !
generic;88;Le nombre maximal de tables %s est depasse
generic;89;Option ou suffixe de recherche invalide !
generic;90;Pas de librairie chargee pour acceder a la base de donnees !
generic;91;Variable d'environnement %s manquante ou non exportee !
generic;92;Parametre <+ recent que> inferieur au parametre <+ vieux que>.
generic;93;Le type de la colonne %s est invalide !
generic;94;Impossible de retrouver le formulaire %s
generic;95;Impossible de retrouver le panneau de commandes %s.
generic;96;L'operateur de selection est incorrect !
generic;97;Aucune valeur donnee
generic;98;La taille maximale %s d'une ligne est depassee !
generic;99;Le champ %s est mal decrit dans la table %s
generic;100;%s
generic;101;Le parametre %s n'est pas un chiffre
generic;102;L'utilisateur %s n'existe pas
generic;103;La cle de reference de la contrainte sur %s est incorrecte.
generic;104;Erreur lors du delete sur %s
generic;105;La variable %s n'est pas du bon type
generic;106;Probleme lors du chargement de l'environnement %s
generic;107;Environnement %s non accessible
generic;108;Probleme pour acceder a la table %s
generic;109;La table %s n'existe pas ou n'est pas accessible
generic;110;Impossible de retrouver l'objet %s
generic;111;La table %s existe sous plusieurs schemas
generic;112;Probleme pour recuperer les contraintes de %s
generic;113;Erreur lors du disable de contraintes de %s
generic;114;Erreur lors de l'enable de contraintes de %s
generic;115;Erreur lors du chargement de la table %s
generic;116;Des enregistrements ont ete rejetes pour la table %s
generic;117;La contrainte %s est invalide !
generic;118;Le nombre maximal %s de cles etrangeres est depasse.
generic;119;Le nombre maximal %s de contraintes est depasse.
generic;120;Impossible de creer le fichier %s
generic;121;La table %s n'est pas une table de reference.
generic;122;La table %s existe sous plusieurs cles etrang�res.
generic;123;Les droits sur le fichier %s sont incorrects.
generic;124;Probleme pour recuperer les informations '%s' de la Machine %s.
generic;125;Le type de la licence est invalide.
generic;126;L'utilisateur %s n'est pas administrateur du systeme.
generic;127;Les colonnes %s doivent absolument contenir une valeur.
generic;128;La table %s ne possede pas de cle primaire.
generic;129;La valeur d'une cle primaire ne peut-etre nulle.
generic;130;Options de commande %s incompatibles
generic;131;Le tri de s�l�ction '%s' est invalide.
generic;132;Le format de la date '%s' est invalide.
generic;133;Les el�ments % de la date doivent �tre s�par�s par un caract�re.
generic;134;La date '%s' ne correspond pas au format %s.
generic;148;Vous n'avez pas les droits %s.
generic;149;Probleme d'environnement %s
generic;150;Mot de Passe inconnu pour le user %s sur la base $ORACLE_SID
generic;151;Variables inconnues BV_ORAUSER et/ou BV_ORAPASS
generic;152;L'intance %s est invalide ou non demarr�e.
V1_alim_30_motcle;0001;ECHEC ce l'Insert Arg de %s dans t_me_alma
V1_alim_30_motcle;0002;Argument de la methode %s non declare dans me_alma
V1_alim_30_motcle;0003;Rang de l'argument de la methode %s incoherent
V1_alim_30_motcle;0004;ECHEC de l'insertion du mot cle %s dans t_me_ma
V1_alim_40_meth;0001;Le mot cle d'action %s n'existe pas
V1_alim_40_meth;0002;L'Insertion de la methode physique %s a echoue
V1_alim_40_meth;0003;L'Insertion de la variable interne %s a echoue
V1_alim_40_meth;0004;L'Insertion du type physique %s a echoue
PC_CHGSTAT_SERV;0004;Aucune instance n'est associee a l'application %s
generic;301;Le module applicatif %s n'est pas ou mal declar�.
generic;302;L'instance de service %s ne semble pas exister.
generic;303;Le script fils <%s> a retourne un warning
generic;304;Le script fils <%s> a retourne une erreur bloquante
generic;305;Le script fils <%s> a retourne une erreur fatale
generic;306;Le script fils <%s> a retourne un code d'erreur errone %s
generic;308;Erreur a l'execution de %s
generic;309;Le service %s '%s' n'existe pas.
generic;310;Le service %s '%s' est deja demarre.
generic;311;Le service %s '%s' est deja arrete.
generic;312;Le service %s '%s' n'a pas demarre correctement.
generic;313;Le service %s '%s' ne s'est pas arrete correctement.
generic;314;Le service %s '%s' n'est pas ou mal declar�.
generic;315;Le module applicatif %s ne poss�de aucune instance de service.
generic;316;La ressource %s '%s' n'est pas ou mal declar�.
generic;317;Impossible de choisir un type pour le Service %s '%s'.
generic;318;Impossible de choisir un type de service pour le I-CLES %s.
generic;319;La table %s n'est pas collectable.
generic;320;Le type de ressource %s n'est pas ou mal d�clar�.
generic;321;Le Type de Service %s du I-CLES %s n'existe pas.
generic;401;Le repertoire %s n'existe pas
generic;402;Impossible de creer le repertoire %s
generic;403;Impossible d'ecrire dans le repertoire %s
generic;404;Impossible de lire le contenu du repertoire %s
generic;405;Le fichier %s n'existe pas ou est vide
generic;406;Le fichier %s existe deja
generic;408;Le fichier %s n'est pas au format %s
generic;409;Erreur lors de l'initialisation du fichier %s
generic;410;Probleme lors de la restauration/decompression de %s
generic;411;Probleme lors de la decompression de %s
generic;412;Probleme lors de la compression de %s
generic;413;Probleme lors de la securisation/compression de %s
generic;414;Le Lecteur %s doit etre NO REWIND pour avancer/reculer
generic;415;Le device %s n'existe pas ou est indisponible
generic;416;Probleme lors de la creation du lien vers %s
generic;417;Le lecteur %s est inaccessible
generic;420;Impossible d'aller sous le r�pertoire '%s'.
ME_CREATE_SYNORA;0001;Probleme a la creation du Synonyme %s
ME_DROP_SYNORA;0001;Probleme a la suppression du Synonyme %s
ME_LOAD_TABORA;0001;Echec du Load sqlldr de %s
ME_RESTORE_TABORA;0001;Erreur lors de la restauration de la table %s
ME_SECURE_TABORA;0001;Impossible de recuperer la taille du tablespace %s
ME_SECURE_TABORA;0002;Impossible de recuperer la taille de la table %s
ME_SECURE_TABORA;0003;Erreur lors de la securisation de la table %s
ME_SECURE_TABORA;0004;Impossible de recuperer la taille de la sauvegarde
ME_SECURE_TABORA;0365;Probleme lors de la mise a jour de la table %s
ME_TRUNC_TABORA;176;Probleme de truncate sur %s (Contrainte type P referencee) 
PC_BACK_TBSORA;137;Probleme pour mettre le TBSPACE %s en BEGIN BACKUP
PC_BACK_TBSORA;138;Probleme pour mettre le TBSPACE %s en END BACKUP
PC_BACK_TBSORA;139;Probleme pour manipuler le TBSPACE %s
PC_LISTBACK_ARCHORA;0001;Il manque la sequence d'archives %s pour la base %s
PC_LISTBACK_ARCHORA;0002;Il n'existe pas d'archives commen�ant a la sequence %s.
PC_LISTBACK_CTRLORA;128;Impossible d'interroger les logfiles de %s
PC_LISTBACK_CTRLORA;132;Impossible d'interroger les controlfiles de %s
PC_LISTID_INSORA;182;Impossible de trouver la Base du user %s
PC_SWITCH_LOGORA;127;Probleme lors du switch des logfiles de %s
PC_SWITCH_LOGORA;128;Impossible d'interroger les logfiles pour %s
generic;501;L'instance Oracle %s n'est pas demarree
generic;502;L'instance Oracle %s n'est pas arretee
generic;503;%s n'est pas un mode d'arret Oracle valide
generic;504;%s n'est pas un mode de demarrage Oracle valide
generic;505;La base Oracle %s existe deja dans /etc/oratab
generic;506;Impossible de retrouver l'environnement de l'instance Oracle %s
generic;507;Impossible de retrouver l'init file de la base %s
generic;508;Le fichier de config de %s n'est pas renseigne dans l'initfile
generic;509;Les controlfiles de %s ne sont pas renseignes dans les initfiles
generic;510;Les parametres d'archive %s n'existent pas dans les initfiles
generic;511;Parametre log_archive_dest de %s non defini dans les initfiles
generic;512;Parametre log_archive_format de %s non defini dans les initfiles
generic;513;L'archivage de %s n'est pas demarre correctement
generic;514;L'archivage de %s n'est pas arrete correctement
generic;515;Script SQL %s non accessible
generic;517;Le script SQL %s ne s'est pas execute correctement
generic;518;Probleme lors de la suppression de la table %s 
generic;519;Probleme a l'execution du delete ou truncate de %s sur $ORACLE_SID
generic;520;Aucun Archive Oracle pour la Base %s
PC_INITF_SQLNET;004;La configuration SqlNet %s de %s est introuvable
FT_LISTLST_SQLNET;346;Aucun Listener convenablement declare dans %s
FT_LIST_TNSNAME;346;Aucun Service TNS convenablement declare dans %s
PC_ENV_SQLNET;506;Impossible de trouver l'environnement de l'instance Sqlnet %s
PC_LISTID_SQLNET;182;Impossible de trouver le Noyau SqlNet du user %s
PC_STAT_TNSNAME;001;Le service TNS %s n'est pas decrit
PC_STAT_TNSNAME;002;Il n'y a pas de listener demarre servant le service TNS %s
PC_STAT_TNSNAME;003;Erreur de configuration de l'adresse du service TNS %s

EXPECTED_OUTPUT
chomp $expected_string;
$expected_error = << 'EXPECTED_ERRSTD';

EXPECTED_ERRSTD
chomp $expected_error;

run3('Select -s from error_messages | Formate_File -', undef, \$return_string, \$return_error);

$home=quotemeta($ENV{TOOLS_HOME});
$return_string =~ s/$home/TOOLS_HOME/g;
$return_error =~ s/$home/TOOLS_HOME/g;

if ( $? == -1 ) {
	BAIL_OUT("<".'Select -s from error_messages | Formate_File -'."> retourne -1");
}
$return_code = $? >> 8;

is ( $return_code ,$expected_code , "<".'Select -s from error_messages | Formate_File -'."> return code $expected_code");
is ( $return_string ,$expected_string , "<".'Select -s from error_messages | Formate_File -'."> output <".q{TEST;1;tes...}.">");

# test si a renvoyer une erreur ou non
is ( $return_error ne '', $expected_error ne '', "<".'Select -s from error_messages | Formate_File -'."> errstd") or diag($return_error);


##################
# Formate_File $SAMPLE/tab/error_messages
##################

$expected_code = 0;
$expected_string = <<'EXPECTED_OUTPUT';
# $Revision: 1.2 $
#----------------------------------
#Fonction (ou generic);Code;Message
#----------------------------------

#-----------------------------------------------------------
#A partir de la Version V1.5 :
#   . Variables d'environnement $... evaluees
#   . Possiblites de substitution de plusieurs arguments %s
#-----------------------------------------------------------

#-----------------------------------------------------------
#A partir de la Version V1.9 :
#   . Mise a jour des messages generiques
#   . Plage 1-200 : ITools
#   . Plage 201-300 : Gasel
#   . Plage 301-400 : Services
#   . Plage 401-500 : Unix
#   . Plage 501-600 : Oracle
#
#Mises a jour effectuees :
#   . Modifications de numeros
#   . Suppression de numeros inutilises
#   . -> Cf. error_messages.old, error_messages.diff
#-----------------------------------------------------------

#-----------------------------------#
# Erreurs generiques ITools : 1-200 #
#-----------------------------------#
TEST;1;test sans quote
TEST;2;test avec ' des ' quote
TEST;3;test avec " des " double quote
TEST;4;test avec \" des \' quote echappees
TEST;5;test avec \\ echappements \n
TEST;6;test avec trop de ; separ;ateurs;
TEST;7;test avec des $variables $TESTVAR
TEST;8;test avec des $variables $(echo "commande evaluee")
TEST;9;test avec des $variables `echo "commande evaluee"`
TEST_${TESTVAR};0;test avec des une clef contenant une variable
Check;65;Non unicite de la clef  # test de commentaire
Insert;8;La condition de selection de cle n'est pas valide
Insert;97;Aucune valeur a inserer n'est specifiee
Modify;8;La condition de selection de la cle n est pas valide
Modify;68;Aucune ligne trouvee a modifier
Modify;97;Aucune valeur a modifier n'est specifiee
Remove;68;Aucune ligne trouvee a supprimer
Replace;8;La condition de selection de la cle n'est pas valide
Replace;68;Aucune ligne trouvee a remplacer
Replace;97;Aucune valeur a remplacer n'est specifiee
generic;1;Impossible de trouver l'executable %s
generic;2;Impossible de trouver la table %s
generic;3;Impossible de trouver ou d'ouvrir le fichier de definition %s
generic;4;Impossible de trouver le fichier %s
generic;5;Le fichier de definition %s n'est pas valide
generic;6;La table %s est une table virtuelle
generic;7;La colonne %s n'existe pas
generic;8;La condition de selection n'est pas valide
generic;9;La chaine de definition %s n'est pas valide ou est absente
generic;10;Impossible d'ouvrir le fichier %s
generic;11;Impossible d'ecrire dans le fichier %s
generic;12;Impossible de supprimer le fichier %s
generic;13;Impossible de changer les droits sur le fichier %s
generic;14;Impossible de renommer/deplacer le fichier %s en %s
generic;15;Impossible de copier le fichier %s
generic;16;Erreur lors d'une ecriture dans le fichier %s
generic;17;La commande <%s> a echoue
generic;18;La variable racine BV_HOME ou TOOLS_HOME n'est pas exportee !
generic;19;L'evaluation de <%s> est incorrecte !
generic;20;L'option %s n'est pas valide
generic;21;Le nombre d'arguments est incorrect
generic;22;L'argument %s n'est pas valide
generic;23;Utilisation incorrecte de l'option -h
generic;24;Ligne de commande incorrecte
generic;25;Erreur lors d'une allocation de memoire %s
generic;26;Erreur lors d'une re-allocation de memoire %s
generic;27;Erreur lors du chargement de la librairie %s !
generic;28;Impossible de retrouver le symbole %s en librairie !
generic;29;Erreur lors de la fermeture de la librairie %s !
generic;30;Votre licence d'utilisation %s a expire !
generic;31;Le Hostid de la machine n'est pas valide !
generic;32;La licence n'est pas valide !
generic;33;Il n'y a pas de licence valide pour ce produit !
generic;34;Le nombre de clients pour ce produit est depasse !
generic;35;Le nom de fichier %s n'est pas valide
generic;36;Le fichier %s est verouille
generic;37;Impossible de poser un verrou sur le fichier %s
generic;38;Le delai maximum d'attente de deverouillage a ete atteint
generic;39;Le fichier %s n'est pas verouille
generic;40;Impossible de retirer le verrou du fichier %s
generic;41;Le nombre maximal de selections simultanees est depasse
generic;42;Le Handle d'une requete n'est pas valide
generic;43;Le nombre maximal de conditions est depasse
generic;44;Impossible de retrouver la librairie %s !
generic;45;Un Handle n'est pas valide
generic;46;Le nombre maximal de fichiers ouverts est depasse
generic;47;Le nombre maximal %s d'allocations de memoire est depasse
generic;48;Impossible de retrouver le fichier de menu %s
generic;49;Impossible de retrouver le dictionnaire graphique %s
generic;50;Erreur lors de l'execution de la fonction de log
generic;51;Erreur de type '%s' lors de la deconnexion Oracle !
generic;52;Impossible d'ecrire dans le fichier log %s
generic;53;Impossible de determiner le nom du traitement
generic;54;Le numero d'erreur est manquant
generic;55;Le message d'information est manquant
generic;56;Le numero d'erreur %s n'a pas de message associe
generic;57;Le numero d'erreur %s n'est pas correct
generic;58;Le type de message de log n'est pas correct
generic;59;Le nom de table %s n'est pas valide
generic;60;La colonne %s doit absolument contenir une valeur
generic;61;Il n'y a pas assez de valeurs par rapport au nombre de colonnes
generic;62;Il y a trop de valeurs par rapport au nombre de colonnes
generic;63;La valeur donnee pour la colonne %s n'est pas correcte.
generic;64;Le nom de la table n'est pas specifie
generic;65;Non unicite de la clef de la ligne a inserer
generic;66;Le groupe d'utilisateurs %s n'existe pas
generic;67;Impossible de remplacer une ligne sur une table sans clef
generic;68;Aucune ligne trouvee
generic;69;Entete de definition invalide !
generic;70;Variables d'environnement SEP ou FORMAT absente !
generic;71;Il n'y a pas de lignes en entree stdin !
generic;72;Impossible d'ouvrir le fichier %s en ecriture !
generic;73;Impossible d'ouvrir le fichier %s en lecture !
generic;74;Impossible d'ouvrir le fichier %s en lecture et ecriture !
generic;75;Erreur generique Oracle : %s
generic;76;Erreur de syntaxe dans la requete SQL generee : %s
generic;77;Une valeur a inserer est trop large pour sa colonne !
generic;78;Impossible de se connecter a Oracle avec l'utilisateur %s
generic;79;Impossible de locker la table %s. Ressource deja occupee !
generic;80;La requete interne SQL s'est terminee en erreur !
generic;81;Le nouveau separateur n'est pas specifie !
generic;82;Le nombre maximal de colonnes %s du dictionnaire est depasse !
generic;83;La colonne %s apparait plusieurs fois dans le dictionnaire !
generic;84;La source de donnees %s du dictionnaire est invalide !
generic;85;La table %s ne peut-etre verouillee ou deverouillee !
generic;86;Vous ne pouvez pas remplacer une cle !
generic;87;Impossible de creer un nouveau processus %s !
generic;88;Le nombre maximal de tables %s est depasse
generic;89;Option ou suffixe de recherche invalide !
generic;90;Pas de librairie chargee pour acceder a la base de donnees !
generic;91;Variable d'environnement %s manquante ou non exportee !
generic;92;Parametre <+ recent que> inferieur au parametre <+ vieux que>.
generic;93;Le type de la colonne %s est invalide !
generic;94;Impossible de retrouver le formulaire %s
generic;95;Impossible de retrouver le panneau de commandes %s.
generic;96;L'operateur de selection est incorrect !
generic;97;Aucune valeur donnee
generic;98;La taille maximale %s d'une ligne est depassee !
generic;99;Le champ %s est mal decrit dans la table %s
generic;100;%s
generic;101;Le parametre %s n'est pas un chiffre
generic;102;L'utilisateur %s n'existe pas
generic;103;La cle de reference de la contrainte sur %s est incorrecte.
generic;104;Erreur lors du delete sur %s
generic;105;La variable %s n'est pas du bon type
generic;106;Probleme lors du chargement de l'environnement %s
generic;107;Environnement %s non accessible
generic;108;Probleme pour acceder a la table %s
generic;109;La table %s n'existe pas ou n'est pas accessible
generic;110;Impossible de retrouver l'objet %s
generic;111;La table %s existe sous plusieurs schemas
generic;112;Probleme pour recuperer les contraintes de %s
generic;113;Erreur lors du disable de contraintes de %s
generic;114;Erreur lors de l'enable de contraintes de %s
generic;115;Erreur lors du chargement de la table %s
generic;116;Des enregistrements ont ete rejetes pour la table %s
generic;117;La contrainte %s est invalide !
generic;118;Le nombre maximal %s de cles etrangeres est depasse.
generic;119;Le nombre maximal %s de contraintes est depasse.
generic;120;Impossible de creer le fichier %s
generic;121;La table %s n'est pas une table de reference.
generic;122;La table %s existe sous plusieurs cles etrang�res.
generic;123;Les droits sur le fichier %s sont incorrects.
generic;124;Probleme pour recuperer les informations '%s' de la Machine %s.
generic;125;Le type de la licence est invalide.
generic;126;L'utilisateur %s n'est pas administrateur du systeme.
generic;127;Les colonnes %s doivent absolument contenir une valeur.
generic;128;La table %s ne possede pas de cle primaire.
generic;129;La valeur d'une cle primaire ne peut-etre nulle.
generic;130;Options de commande %s incompatibles
generic;131;Le tri de s�l�ction '%s' est invalide.
generic;132;Le format de la date '%s' est invalide.
generic;133;Les el�ments % de la date doivent �tre s�par�s par un caract�re.
generic;134;La date '%s' ne correspond pas au format %s.
generic;148;Vous n'avez pas les droits %s.
generic;149;Probleme d'environnement %s
generic;150;Mot de Passe inconnu pour le user %s sur la base $ORACLE_SID
generic;151;Variables inconnues BV_ORAUSER et/ou BV_ORAPASS
generic;152;L'intance %s est invalide ou non demarr�e.

#-------------------------#
# Erreurs GASEL : 201-300 #
#-------------------------#
V1_alim_30_motcle;0001;ECHEC ce l'Insert Arg de %s dans t_me_alma
V1_alim_30_motcle;0002;Argument de la methode %s non declare dans me_alma
V1_alim_30_motcle;0003;Rang de l'argument de la methode %s incoherent
V1_alim_30_motcle;0004;ECHEC de l'insertion du mot cle %s dans t_me_ma
V1_alim_40_meth;0001;Le mot cle d'action %s n'existe pas
V1_alim_40_meth;0002;L'Insertion de la methode physique %s a echoue
V1_alim_40_meth;0003;L'Insertion de la variable interne %s a echoue
V1_alim_40_meth;0004;L'Insertion du type physique %s a echoue

#---------------------------------------#
# Erreurs generiques Services : 301-400 #
#---------------------------------------#
PC_CHGSTAT_SERV;0004;Aucune instance n'est associee a l'application %s
generic;301;Le module applicatif %s n'est pas ou mal declar�.
generic;302;L'instance de service %s ne semble pas exister.
generic;303;Le script fils <%s> a retourne un warning
generic;304;Le script fils <%s> a retourne une erreur bloquante
generic;305;Le script fils <%s> a retourne une erreur fatale
generic;306;Le script fils <%s> a retourne un code d'erreur errone %s
generic;308;Erreur a l'execution de %s
generic;309;Le service %s '%s' n'existe pas.
generic;310;Le service %s '%s' est deja demarre.
generic;311;Le service %s '%s' est deja arrete.
generic;312;Le service %s '%s' n'a pas demarre correctement.
generic;313;Le service %s '%s' ne s'est pas arrete correctement.
generic;314;Le service %s '%s' n'est pas ou mal declar�.
generic;315;Le module applicatif %s ne poss�de aucune instance de service.
generic;316;La ressource %s '%s' n'est pas ou mal declar�.
generic;317;Impossible de choisir un type pour le Service %s '%s'.
generic;318;Impossible de choisir un type de service pour le I-CLES %s.
generic;319;La table %s n'est pas collectable.
generic;320;Le type de ressource %s n'est pas ou mal d�clar�.
generic;321;Le Type de Service %s du I-CLES %s n'existe pas.

#-----------------------------------#
# Erreurs generiques Unix : 401-500 #
#-----------------------------------#
generic;401;Le repertoire %s n'existe pas
generic;402;Impossible de creer le repertoire %s
generic;403;Impossible d'ecrire dans le repertoire %s
generic;404;Impossible de lire le contenu du repertoire %s
generic;405;Le fichier %s n'existe pas ou est vide
generic;406;Le fichier %s existe deja
generic;408;Le fichier %s n'est pas au format %s
generic;409;Erreur lors de l'initialisation du fichier %s
generic;410;Probleme lors de la restauration/decompression de %s
generic;411;Probleme lors de la decompression de %s
generic;412;Probleme lors de la compression de %s
generic;413;Probleme lors de la securisation/compression de %s
generic;414;Le Lecteur %s doit etre NO REWIND pour avancer/reculer
generic;415;Le device %s n'existe pas ou est indisponible
generic;416;Probleme lors de la creation du lien vers %s
generic;417;Le lecteur %s est inaccessible
generic;420;Impossible d'aller sous le r�pertoire '%s'.

#-------------------------------------#
# Erreurs generiques Oracle : 501-600 #
#-------------------------------------#
ME_CREATE_SYNORA;0001;Probleme a la creation du Synonyme %s
ME_DROP_SYNORA;0001;Probleme a la suppression du Synonyme %s
ME_LOAD_TABORA;0001;Echec du Load sqlldr de %s
ME_RESTORE_TABORA;0001;Erreur lors de la restauration de la table %s
ME_SECURE_TABORA;0001;Impossible de recuperer la taille du tablespace %s
ME_SECURE_TABORA;0002;Impossible de recuperer la taille de la table %s
ME_SECURE_TABORA;0003;Erreur lors de la securisation de la table %s
ME_SECURE_TABORA;0004;Impossible de recuperer la taille de la sauvegarde
ME_SECURE_TABORA;0365;Probleme lors de la mise a jour de la table %s
ME_TRUNC_TABORA;176;Probleme de truncate sur %s (Contrainte type P referencee) 
PC_BACK_TBSORA;137;Probleme pour mettre le TBSPACE %s en BEGIN BACKUP
PC_BACK_TBSORA;138;Probleme pour mettre le TBSPACE %s en END BACKUP
PC_BACK_TBSORA;139;Probleme pour manipuler le TBSPACE %s
PC_LISTBACK_ARCHORA;0001;Il manque la sequence d'archives %s pour la base %s
PC_LISTBACK_ARCHORA;0002;Il n'existe pas d'archives commen�ant a la sequence %s.
PC_LISTBACK_CTRLORA;128;Impossible d'interroger les logfiles de %s
PC_LISTBACK_CTRLORA;132;Impossible d'interroger les controlfiles de %s
PC_LISTID_INSORA;182;Impossible de trouver la Base du user %s
PC_SWITCH_LOGORA;127;Probleme lors du switch des logfiles de %s
PC_SWITCH_LOGORA;128;Impossible d'interroger les logfiles pour %s
generic;501;L'instance Oracle %s n'est pas demarree
generic;502;L'instance Oracle %s n'est pas arretee
generic;503;%s n'est pas un mode d'arret Oracle valide
generic;504;%s n'est pas un mode de demarrage Oracle valide
generic;505;La base Oracle %s existe deja dans /etc/oratab
generic;506;Impossible de retrouver l'environnement de l'instance Oracle %s
generic;507;Impossible de retrouver l'init file de la base %s
generic;508;Le fichier de config de %s n'est pas renseigne dans l'initfile
generic;509;Les controlfiles de %s ne sont pas renseignes dans les initfiles
generic;510;Les parametres d'archive %s n'existent pas dans les initfiles
generic;511;Parametre log_archive_dest de %s non defini dans les initfiles
generic;512;Parametre log_archive_format de %s non defini dans les initfiles
generic;513;L'archivage de %s n'est pas demarre correctement
generic;514;L'archivage de %s n'est pas arrete correctement
generic;515;Script SQL %s non accessible
generic;517;Le script SQL %s ne s'est pas execute correctement
generic;518;Probleme lors de la suppression de la table %s 
generic;519;Probleme a l'execution du delete ou truncate de %s sur $ORACLE_SID
generic;520;Aucun Archive Oracle pour la Base %s

#----------------#
# Erreurs SQLNET #
#----------------#
PC_INITF_SQLNET;004;La configuration SqlNet %s de %s est introuvable
FT_LISTLST_SQLNET;346;Aucun Listener convenablement declare dans %s
FT_LIST_TNSNAME;346;Aucun Service TNS convenablement declare dans %s
PC_ENV_SQLNET;506;Impossible de trouver l'environnement de l'instance Sqlnet %s
PC_LISTID_SQLNET;182;Impossible de trouver le Noyau SqlNet du user %s
PC_STAT_TNSNAME;001;Le service TNS %s n'est pas decrit
PC_STAT_TNSNAME;002;Il n'y a pas de listener demarre servant le service TNS %s
PC_STAT_TNSNAME;003;Erreur de configuration de l'adresse du service TNS %s

EXPECTED_OUTPUT
chomp $expected_string;
$expected_error = << 'EXPECTED_ERRSTD';

EXPECTED_ERRSTD
chomp $expected_error;

run3('Formate_File $SAMPLE/tab/error_messages', undef, \$return_string, \$return_error);

$home=quotemeta($ENV{TOOLS_HOME});
$return_string =~ s/$home/TOOLS_HOME/g;
$return_error =~ s/$home/TOOLS_HOME/g;

if ( $? == -1 ) {
	BAIL_OUT("<".'Formate_File $SAMPLE/tab/error_messages'."> retourne -1");
}
$return_code = $? >> 8;

is ( $return_code ,$expected_code , "<".'Formate_File $SAMPLE/tab/error_messages'."> return code $expected_code");
is ( $return_string ,$expected_string , "<".'Formate_File $SAMPLE/tab/error_messages'."> output <".q{# $Revisio...}.">");

# test si a renvoyer une erreur ou non
is ( $return_error ne '', $expected_error ne '', "<".'Formate_File $SAMPLE/tab/error_messages'."> errstd") or diag($return_error);


##################
# Select -s from table_simple | Formate_File -s%/: -
##################

$expected_code = 0;
$expected_string = <<'EXPECTED_OUTPUT';
1:premier:20110101120000:1:20
2:deuxieme:20120101120000:0:40
3:troisieme:20100101120000:o:60
4:quatrieme:20110101140001:Y:80
5:cinquieme:20110101140002:Y:90
6:sixieme:20110101140003:Y:100n
7:septieme:20110101140004X:Y:10
8:huitieme:20110101140004:errror_bool:10
toto:mauvais ID:20110101140005:0:20

EXPECTED_OUTPUT
chomp $expected_string;
$expected_error = << 'EXPECTED_ERRSTD';

EXPECTED_ERRSTD
chomp $expected_error;

run3('Select -s from table_simple | Formate_File -s%/: -', undef, \$return_string, \$return_error);

$home=quotemeta($ENV{TOOLS_HOME});
$return_string =~ s/$home/TOOLS_HOME/g;
$return_error =~ s/$home/TOOLS_HOME/g;

if ( $? == -1 ) {
	BAIL_OUT("<".'Select -s from table_simple | Formate_File -s%/: -'."> retourne -1");
}
$return_code = $? >> 8;

is ( $return_code ,$expected_code , "<".'Select -s from table_simple | Formate_File -s%/: -'."> return code $expected_code");
is ( $return_string ,$expected_string , "<".'Select -s from table_simple | Formate_File -s%/: -'."> output <".q{1:premier:...}.">");

# test si a renvoyer une erreur ou non
is ( $return_error ne '', $expected_error ne '', "<".'Select -s from table_simple | Formate_File -s%/: -'."> errstd") or diag($return_error);


##################
# Select -s from table_simple | Formate_File -s%/:: -
##################

$expected_code = 0;
$expected_string = <<'EXPECTED_OUTPUT';
1::premier::20110101120000::1::20
2::deuxieme::20120101120000::0::40
3::troisieme::20100101120000::o::60
4::quatrieme::20110101140001::Y::80
5::cinquieme::20110101140002::Y::90
6::sixieme::20110101140003::Y::100n
7::septieme::20110101140004X::Y::10
8::huitieme::20110101140004::errror_bool::10
toto::mauvais ID::20110101140005::0::20

EXPECTED_OUTPUT
chomp $expected_string;
$expected_error = << 'EXPECTED_ERRSTD';

EXPECTED_ERRSTD
chomp $expected_error;

run3('Select -s from table_simple | Formate_File -s%/:: -', undef, \$return_string, \$return_error);

$home=quotemeta($ENV{TOOLS_HOME});
$return_string =~ s/$home/TOOLS_HOME/g;
$return_error =~ s/$home/TOOLS_HOME/g;

if ( $? == -1 ) {
	BAIL_OUT("<".'Select -s from table_simple | Formate_File -s%/:: -'."> retourne -1");
}
$return_code = $? >> 8;

is ( $return_code ,$expected_code , "<".'Select -s from table_simple | Formate_File -s%/:: -'."> return code $expected_code");
is ( $return_string ,$expected_string , "<".'Select -s from table_simple | Formate_File -s%/:: -'."> output <".q{1::premier...}.">");

# test si a renvoyer une erreur ou non
is ( $return_error ne '', $expected_error ne '', "<".'Select -s from table_simple | Formate_File -s%/:: -'."> errstd") or diag($return_error);


##################
# Select -s from table_simple | Formate_File -s':/\t' -
##################

$expected_code = 0;
$expected_string = <<'EXPECTED_OUTPUT';
1%premier%20110101120000%1%20
2%deuxieme%20120101120000%0%40
3%troisieme%20100101120000%o%60
4%quatrieme%20110101140001%Y%80
5%cinquieme%20110101140002%Y%90
6%sixieme%20110101140003%Y%100n
7%septieme%20110101140004X%Y%10
8%huitieme%20110101140004%errror_bool%10
toto%mauvais ID%20110101140005%0%20

EXPECTED_OUTPUT
chomp $expected_string;
$expected_error = << 'EXPECTED_ERRSTD';

EXPECTED_ERRSTD
chomp $expected_error;

run3('Select -s from table_simple | Formate_File -s\':/\\t\' -', undef, \$return_string, \$return_error);

$home=quotemeta($ENV{TOOLS_HOME});
$return_string =~ s/$home/TOOLS_HOME/g;
$return_error =~ s/$home/TOOLS_HOME/g;

if ( $? == -1 ) {
	BAIL_OUT("<".'Select -s from table_simple | Formate_File -s\':/\\t\' -'."> retourne -1");
}
$return_code = $? >> 8;

is ( $return_code ,$expected_code , "<".'Select -s from table_simple | Formate_File -s\':/\\t\' -'."> return code $expected_code");
is ( $return_string ,$expected_string , "<".'Select -s from table_simple | Formate_File -s\':/\\t\' -'."> output <".q{1%premier%...}.">");

# test si a renvoyer une erreur ou non
is ( $return_error ne '', $expected_error ne '', "<".'Select -s from table_simple | Formate_File -s\':/\\t\' -'."> errstd") or diag($return_error);


##################
# Select -s from table_simple | Formate_File -s":/\t" -
##################

$expected_code = 0;
$expected_string = <<'EXPECTED_OUTPUT';
1%premier%20110101120000%1%20
2%deuxieme%20120101120000%0%40
3%troisieme%20100101120000%o%60
4%quatrieme%20110101140001%Y%80
5%cinquieme%20110101140002%Y%90
6%sixieme%20110101140003%Y%100n
7%septieme%20110101140004X%Y%10
8%huitieme%20110101140004%errror_bool%10
toto%mauvais ID%20110101140005%0%20

EXPECTED_OUTPUT
chomp $expected_string;
$expected_error = << 'EXPECTED_ERRSTD';

EXPECTED_ERRSTD
chomp $expected_error;

run3('Select -s from table_simple | Formate_File -s":/\\t" -', undef, \$return_string, \$return_error);

$home=quotemeta($ENV{TOOLS_HOME});
$return_string =~ s/$home/TOOLS_HOME/g;
$return_error =~ s/$home/TOOLS_HOME/g;

if ( $? == -1 ) {
	BAIL_OUT("<".'Select -s from table_simple | Formate_File -s":/\\t" -'."> retourne -1");
}
$return_code = $? >> 8;

is ( $return_code ,$expected_code , "<".'Select -s from table_simple | Formate_File -s":/\\t" -'."> return code $expected_code");
is ( $return_string ,$expected_string , "<".'Select -s from table_simple | Formate_File -s":/\\t" -'."> output <".q{1%premier%...}.">");

# test si a renvoyer une erreur ou non
is ( $return_error ne '', $expected_error ne '', "<".'Select -s from table_simple | Formate_File -s":/\\t" -'."> errstd") or diag($return_error);


##################
# Select -s from error_messages | Formate_File -s\;/% -n 0 -
##################

$expected_code = 202;
$expected_string = <<'EXPECTED_OUTPUT';

EXPECTED_OUTPUT
chomp $expected_string;
$expected_error = << 'EXPECTED_ERRSTD';
Procedure : Formate_File, Type : Erreur, Severite : 202
Message : Le parametre 0 n'est pas un chiffre

EXPECTED_ERRSTD
chomp $expected_error;

run3('Select -s from error_messages | Formate_File -s\\;/% -n 0 -', undef, \$return_string, \$return_error);

$home=quotemeta($ENV{TOOLS_HOME});
$return_string =~ s/$home/TOOLS_HOME/g;
$return_error =~ s/$home/TOOLS_HOME/g;

if ( $? == -1 ) {
	BAIL_OUT("<".'Select -s from error_messages | Formate_File -s\\;/% -n 0 -'."> retourne -1");
}
$return_code = $? >> 8;

is ( $return_code ,$expected_code , "<".'Select -s from error_messages | Formate_File -s\\;/% -n 0 -'."> return code $expected_code");
is ( $return_string ,$expected_string , "<".'Select -s from error_messages | Formate_File -s\\;/% -n 0 -'."> output <".q{}.">");

# test si a renvoyer une erreur ou non
is ( $return_error ne '', $expected_error ne '', "<".'Select -s from error_messages | Formate_File -s\\;/% -n 0 -'."> errstd") or diag($return_error);


##################
# Select -s from error_messages | Formate_File -s";/\n" -
##################

$expected_code = 202;
$expected_string = <<'EXPECTED_OUTPUT';

EXPECTED_OUTPUT
chomp $expected_string;
$expected_error = << 'EXPECTED_ERRSTD';
Procedure : Formate_File, Type : Erreur, Severite : 202
Message : L'argument ;/\n n'est pas valide
Procedure : Formate_File, Type : Info, Severite : 202
Message : USAGE: Formate_File [-h]  [-s Sep/NewSep [-n NbFields]] File | -

EXPECTED_ERRSTD
chomp $expected_error;

run3('Select -s from error_messages | Formate_File -s";/\\n" -', undef, \$return_string, \$return_error);

$home=quotemeta($ENV{TOOLS_HOME});
$return_string =~ s/$home/TOOLS_HOME/g;
$return_error =~ s/$home/TOOLS_HOME/g;

if ( $? == -1 ) {
	BAIL_OUT("<".'Select -s from error_messages | Formate_File -s";/\\n" -'."> retourne -1");
}
$return_code = $? >> 8;

is ( $return_code ,$expected_code , "<".'Select -s from error_messages | Formate_File -s";/\\n" -'."> return code $expected_code");
is ( $return_string ,$expected_string , "<".'Select -s from error_messages | Formate_File -s";/\\n" -'."> output <".q{}.">");

# test si a renvoyer une erreur ou non
is ( $return_error ne '', $expected_error ne '', "<".'Select -s from error_messages | Formate_File -s";/\\n" -'."> errstd") or diag($return_error);


##################
# Select -s from error_messages | Formate_File -s\;/% -n 1 -
##################

$expected_code = 0;
$expected_string = <<'EXPECTED_OUTPUT';
TEST;1;test sans quote
TEST;2;test avec ' des ' quote
TEST;3;test avec " des " double quote
TEST;4;test avec \" des \' quote echappees
TEST;5;test avec \\ echappements \n
TEST;6;test avec trop de ; separ;ateurs;
TEST;7;test avec des $variables $TESTVAR
TEST;8;test avec des $variables $(echo "commande evaluee")
TEST;9;test avec des $variables `echo "commande evaluee"`
TEST_${TESTVAR};0;test avec des une clef contenant une variable
Check;65;Non unicite de la clef
Insert;8;La condition de selection de cle n'est pas valide
Insert;97;Aucune valeur a inserer n'est specifiee
Modify;8;La condition de selection de la cle n est pas valide
Modify;68;Aucune ligne trouvee a modifier
Modify;97;Aucune valeur a modifier n'est specifiee
Remove;68;Aucune ligne trouvee a supprimer
Replace;8;La condition de selection de la cle n'est pas valide
Replace;68;Aucune ligne trouvee a remplacer
Replace;97;Aucune valeur a remplacer n'est specifiee
generic;1;Impossible de trouver l'executable %s
generic;2;Impossible de trouver la table %s
generic;3;Impossible de trouver ou d'ouvrir le fichier de definition %s
generic;4;Impossible de trouver le fichier %s
generic;5;Le fichier de definition %s n'est pas valide
generic;6;La table %s est une table virtuelle
generic;7;La colonne %s n'existe pas
generic;8;La condition de selection n'est pas valide
generic;9;La chaine de definition %s n'est pas valide ou est absente
generic;10;Impossible d'ouvrir le fichier %s
generic;11;Impossible d'ecrire dans le fichier %s
generic;12;Impossible de supprimer le fichier %s
generic;13;Impossible de changer les droits sur le fichier %s
generic;14;Impossible de renommer/deplacer le fichier %s en %s
generic;15;Impossible de copier le fichier %s
generic;16;Erreur lors d'une ecriture dans le fichier %s
generic;17;La commande <%s> a echoue
generic;18;La variable racine BV_HOME ou TOOLS_HOME n'est pas exportee !
generic;19;L'evaluation de <%s> est incorrecte !
generic;20;L'option %s n'est pas valide
generic;21;Le nombre d'arguments est incorrect
generic;22;L'argument %s n'est pas valide
generic;23;Utilisation incorrecte de l'option -h
generic;24;Ligne de commande incorrecte
generic;25;Erreur lors d'une allocation de memoire %s
generic;26;Erreur lors d'une re-allocation de memoire %s
generic;27;Erreur lors du chargement de la librairie %s !
generic;28;Impossible de retrouver le symbole %s en librairie !
generic;29;Erreur lors de la fermeture de la librairie %s !
generic;30;Votre licence d'utilisation %s a expire !
generic;31;Le Hostid de la machine n'est pas valide !
generic;32;La licence n'est pas valide !
generic;33;Il n'y a pas de licence valide pour ce produit !
generic;34;Le nombre de clients pour ce produit est depasse !
generic;35;Le nom de fichier %s n'est pas valide
generic;36;Le fichier %s est verouille
generic;37;Impossible de poser un verrou sur le fichier %s
generic;38;Le delai maximum d'attente de deverouillage a ete atteint
generic;39;Le fichier %s n'est pas verouille
generic;40;Impossible de retirer le verrou du fichier %s
generic;41;Le nombre maximal de selections simultanees est depasse
generic;42;Le Handle d'une requete n'est pas valide
generic;43;Le nombre maximal de conditions est depasse
generic;44;Impossible de retrouver la librairie %s !
generic;45;Un Handle n'est pas valide
generic;46;Le nombre maximal de fichiers ouverts est depasse
generic;47;Le nombre maximal %s d'allocations de memoire est depasse
generic;48;Impossible de retrouver le fichier de menu %s
generic;49;Impossible de retrouver le dictionnaire graphique %s
generic;50;Erreur lors de l'execution de la fonction de log
generic;51;Erreur de type '%s' lors de la deconnexion Oracle !
generic;52;Impossible d'ecrire dans le fichier log %s
generic;53;Impossible de determiner le nom du traitement
generic;54;Le numero d'erreur est manquant
generic;55;Le message d'information est manquant
generic;56;Le numero d'erreur %s n'a pas de message associe
generic;57;Le numero d'erreur %s n'est pas correct
generic;58;Le type de message de log n'est pas correct
generic;59;Le nom de table %s n'est pas valide
generic;60;La colonne %s doit absolument contenir une valeur
generic;61;Il n'y a pas assez de valeurs par rapport au nombre de colonnes
generic;62;Il y a trop de valeurs par rapport au nombre de colonnes
generic;63;La valeur donnee pour la colonne %s n'est pas correcte.
generic;64;Le nom de la table n'est pas specifie
generic;65;Non unicite de la clef de la ligne a inserer
generic;66;Le groupe d'utilisateurs %s n'existe pas
generic;67;Impossible de remplacer une ligne sur une table sans clef
generic;68;Aucune ligne trouvee
generic;69;Entete de definition invalide !
generic;70;Variables d'environnement SEP ou FORMAT absente !
generic;71;Il n'y a pas de lignes en entree stdin !
generic;72;Impossible d'ouvrir le fichier %s en ecriture !
generic;73;Impossible d'ouvrir le fichier %s en lecture !
generic;74;Impossible d'ouvrir le fichier %s en lecture et ecriture !
generic;75;Erreur generique Oracle : %s
generic;76;Erreur de syntaxe dans la requete SQL generee : %s
generic;77;Une valeur a inserer est trop large pour sa colonne !
generic;78;Impossible de se connecter a Oracle avec l'utilisateur %s
generic;79;Impossible de locker la table %s. Ressource deja occupee !
generic;80;La requete interne SQL s'est terminee en erreur !
generic;81;Le nouveau separateur n'est pas specifie !
generic;82;Le nombre maximal de colonnes %s du dictionnaire est depasse !
generic;83;La colonne %s apparait plusieurs fois dans le dictionnaire !
generic;84;La source de donnees %s du dictionnaire est invalide !
generic;85;La table %s ne peut-etre verouillee ou deverouillee !
generic;86;Vous ne pouvez pas remplacer une cle !
generic;87;Impossible de creer un nouveau processus %s !
generic;88;Le nombre maximal de tables %s est depasse
generic;89;Option ou suffixe de recherche invalide !
generic;90;Pas de librairie chargee pour acceder a la base de donnees !
generic;91;Variable d'environnement %s manquante ou non exportee !
generic;92;Parametre <+ recent que> inferieur au parametre <+ vieux que>.
generic;93;Le type de la colonne %s est invalide !
generic;94;Impossible de retrouver le formulaire %s
generic;95;Impossible de retrouver le panneau de commandes %s.
generic;96;L'operateur de selection est incorrect !
generic;97;Aucune valeur donnee
generic;98;La taille maximale %s d'une ligne est depassee !
generic;99;Le champ %s est mal decrit dans la table %s
generic;100;%s
generic;101;Le parametre %s n'est pas un chiffre
generic;102;L'utilisateur %s n'existe pas
generic;103;La cle de reference de la contrainte sur %s est incorrecte.
generic;104;Erreur lors du delete sur %s
generic;105;La variable %s n'est pas du bon type
generic;106;Probleme lors du chargement de l'environnement %s
generic;107;Environnement %s non accessible
generic;108;Probleme pour acceder a la table %s
generic;109;La table %s n'existe pas ou n'est pas accessible
generic;110;Impossible de retrouver l'objet %s
generic;111;La table %s existe sous plusieurs schemas
generic;112;Probleme pour recuperer les contraintes de %s
generic;113;Erreur lors du disable de contraintes de %s
generic;114;Erreur lors de l'enable de contraintes de %s
generic;115;Erreur lors du chargement de la table %s
generic;116;Des enregistrements ont ete rejetes pour la table %s
generic;117;La contrainte %s est invalide !
generic;118;Le nombre maximal %s de cles etrangeres est depasse.
generic;119;Le nombre maximal %s de contraintes est depasse.
generic;120;Impossible de creer le fichier %s
generic;121;La table %s n'est pas une table de reference.
generic;122;La table %s existe sous plusieurs cles etrang�res.
generic;123;Les droits sur le fichier %s sont incorrects.
generic;124;Probleme pour recuperer les informations '%s' de la Machine %s.
generic;125;Le type de la licence est invalide.
generic;126;L'utilisateur %s n'est pas administrateur du systeme.
generic;127;Les colonnes %s doivent absolument contenir une valeur.
generic;128;La table %s ne possede pas de cle primaire.
generic;129;La valeur d'une cle primaire ne peut-etre nulle.
generic;130;Options de commande %s incompatibles
generic;131;Le tri de s�l�ction '%s' est invalide.
generic;132;Le format de la date '%s' est invalide.
generic;133;Les el�ments % de la date doivent �tre s�par�s par un caract�re.
generic;134;La date '%s' ne correspond pas au format %s.
generic;148;Vous n'avez pas les droits %s.
generic;149;Probleme d'environnement %s
generic;150;Mot de Passe inconnu pour le user %s sur la base $ORACLE_SID
generic;151;Variables inconnues BV_ORAUSER et/ou BV_ORAPASS
generic;152;L'intance %s est invalide ou non demarr�e.
V1_alim_30_motcle;0001;ECHEC ce l'Insert Arg de %s dans t_me_alma
V1_alim_30_motcle;0002;Argument de la methode %s non declare dans me_alma
V1_alim_30_motcle;0003;Rang de l'argument de la methode %s incoherent
V1_alim_30_motcle;0004;ECHEC de l'insertion du mot cle %s dans t_me_ma
V1_alim_40_meth;0001;Le mot cle d'action %s n'existe pas
V1_alim_40_meth;0002;L'Insertion de la methode physique %s a echoue
V1_alim_40_meth;0003;L'Insertion de la variable interne %s a echoue
V1_alim_40_meth;0004;L'Insertion du type physique %s a echoue
PC_CHGSTAT_SERV;0004;Aucune instance n'est associee a l'application %s
generic;301;Le module applicatif %s n'est pas ou mal declar�.
generic;302;L'instance de service %s ne semble pas exister.
generic;303;Le script fils <%s> a retourne un warning
generic;304;Le script fils <%s> a retourne une erreur bloquante
generic;305;Le script fils <%s> a retourne une erreur fatale
generic;306;Le script fils <%s> a retourne un code d'erreur errone %s
generic;308;Erreur a l'execution de %s
generic;309;Le service %s '%s' n'existe pas.
generic;310;Le service %s '%s' est deja demarre.
generic;311;Le service %s '%s' est deja arrete.
generic;312;Le service %s '%s' n'a pas demarre correctement.
generic;313;Le service %s '%s' ne s'est pas arrete correctement.
generic;314;Le service %s '%s' n'est pas ou mal declar�.
generic;315;Le module applicatif %s ne poss�de aucune instance de service.
generic;316;La ressource %s '%s' n'est pas ou mal declar�.
generic;317;Impossible de choisir un type pour le Service %s '%s'.
generic;318;Impossible de choisir un type de service pour le I-CLES %s.
generic;319;La table %s n'est pas collectable.
generic;320;Le type de ressource %s n'est pas ou mal d�clar�.
generic;321;Le Type de Service %s du I-CLES %s n'existe pas.
generic;401;Le repertoire %s n'existe pas
generic;402;Impossible de creer le repertoire %s
generic;403;Impossible d'ecrire dans le repertoire %s
generic;404;Impossible de lire le contenu du repertoire %s
generic;405;Le fichier %s n'existe pas ou est vide
generic;406;Le fichier %s existe deja
generic;408;Le fichier %s n'est pas au format %s
generic;409;Erreur lors de l'initialisation du fichier %s
generic;410;Probleme lors de la restauration/decompression de %s
generic;411;Probleme lors de la decompression de %s
generic;412;Probleme lors de la compression de %s
generic;413;Probleme lors de la securisation/compression de %s
generic;414;Le Lecteur %s doit etre NO REWIND pour avancer/reculer
generic;415;Le device %s n'existe pas ou est indisponible
generic;416;Probleme lors de la creation du lien vers %s
generic;417;Le lecteur %s est inaccessible
generic;420;Impossible d'aller sous le r�pertoire '%s'.
ME_CREATE_SYNORA;0001;Probleme a la creation du Synonyme %s
ME_DROP_SYNORA;0001;Probleme a la suppression du Synonyme %s
ME_LOAD_TABORA;0001;Echec du Load sqlldr de %s
ME_RESTORE_TABORA;0001;Erreur lors de la restauration de la table %s
ME_SECURE_TABORA;0001;Impossible de recuperer la taille du tablespace %s
ME_SECURE_TABORA;0002;Impossible de recuperer la taille de la table %s
ME_SECURE_TABORA;0003;Erreur lors de la securisation de la table %s
ME_SECURE_TABORA;0004;Impossible de recuperer la taille de la sauvegarde
ME_SECURE_TABORA;0365;Probleme lors de la mise a jour de la table %s
ME_TRUNC_TABORA;176;Probleme de truncate sur %s (Contrainte type P referencee) 
PC_BACK_TBSORA;137;Probleme pour mettre le TBSPACE %s en BEGIN BACKUP
PC_BACK_TBSORA;138;Probleme pour mettre le TBSPACE %s en END BACKUP
PC_BACK_TBSORA;139;Probleme pour manipuler le TBSPACE %s
PC_LISTBACK_ARCHORA;0001;Il manque la sequence d'archives %s pour la base %s
PC_LISTBACK_ARCHORA;0002;Il n'existe pas d'archives commen�ant a la sequence %s.
PC_LISTBACK_CTRLORA;128;Impossible d'interroger les logfiles de %s
PC_LISTBACK_CTRLORA;132;Impossible d'interroger les controlfiles de %s
PC_LISTID_INSORA;182;Impossible de trouver la Base du user %s
PC_SWITCH_LOGORA;127;Probleme lors du switch des logfiles de %s
PC_SWITCH_LOGORA;128;Impossible d'interroger les logfiles pour %s
generic;501;L'instance Oracle %s n'est pas demarree
generic;502;L'instance Oracle %s n'est pas arretee
generic;503;%s n'est pas un mode d'arret Oracle valide
generic;504;%s n'est pas un mode de demarrage Oracle valide
generic;505;La base Oracle %s existe deja dans /etc/oratab
generic;506;Impossible de retrouver l'environnement de l'instance Oracle %s
generic;507;Impossible de retrouver l'init file de la base %s
generic;508;Le fichier de config de %s n'est pas renseigne dans l'initfile
generic;509;Les controlfiles de %s ne sont pas renseignes dans les initfiles
generic;510;Les parametres d'archive %s n'existent pas dans les initfiles
generic;511;Parametre log_archive_dest de %s non defini dans les initfiles
generic;512;Parametre log_archive_format de %s non defini dans les initfiles
generic;513;L'archivage de %s n'est pas demarre correctement
generic;514;L'archivage de %s n'est pas arrete correctement
generic;515;Script SQL %s non accessible
generic;517;Le script SQL %s ne s'est pas execute correctement
generic;518;Probleme lors de la suppression de la table %s 
generic;519;Probleme a l'execution du delete ou truncate de %s sur $ORACLE_SID
generic;520;Aucun Archive Oracle pour la Base %s
PC_INITF_SQLNET;004;La configuration SqlNet %s de %s est introuvable
FT_LISTLST_SQLNET;346;Aucun Listener convenablement declare dans %s
FT_LIST_TNSNAME;346;Aucun Service TNS convenablement declare dans %s
PC_ENV_SQLNET;506;Impossible de trouver l'environnement de l'instance Sqlnet %s
PC_LISTID_SQLNET;182;Impossible de trouver le Noyau SqlNet du user %s
PC_STAT_TNSNAME;001;Le service TNS %s n'est pas decrit
PC_STAT_TNSNAME;002;Il n'y a pas de listener demarre servant le service TNS %s
PC_STAT_TNSNAME;003;Erreur de configuration de l'adresse du service TNS %s

EXPECTED_OUTPUT
chomp $expected_string;
$expected_error = << 'EXPECTED_ERRSTD';

EXPECTED_ERRSTD
chomp $expected_error;

run3('Select -s from error_messages | Formate_File -s\\;/% -n 1 -', undef, \$return_string, \$return_error);

$home=quotemeta($ENV{TOOLS_HOME});
$return_string =~ s/$home/TOOLS_HOME/g;
$return_error =~ s/$home/TOOLS_HOME/g;

if ( $? == -1 ) {
	BAIL_OUT("<".'Select -s from error_messages | Formate_File -s\\;/% -n 1 -'."> retourne -1");
}
$return_code = $? >> 8;

is ( $return_code ,$expected_code , "<".'Select -s from error_messages | Formate_File -s\\;/% -n 1 -'."> return code $expected_code");
is ( $return_string ,$expected_string , "<".'Select -s from error_messages | Formate_File -s\\;/% -n 1 -'."> output <".q{TEST;1;tes...}.">");

# test si a renvoyer une erreur ou non
is ( $return_error ne '', $expected_error ne '', "<".'Select -s from error_messages | Formate_File -s\\;/% -n 1 -'."> errstd") or diag($return_error);


##################
# Select -s from error_messages | Formate_File -s\;/% -n 2 -
##################

$expected_code = 0;
$expected_string = <<'EXPECTED_OUTPUT';
TEST%1;test sans quote
TEST%2;test avec ' des ' quote
TEST%3;test avec " des " double quote
TEST%4;test avec \" des \' quote echappees
TEST%5;test avec \\ echappements \n
TEST%6;test avec trop de ; separ;ateurs;
TEST%7;test avec des $variables $TESTVAR
TEST%8;test avec des $variables $(echo "commande evaluee")
TEST%9;test avec des $variables `echo "commande evaluee"`
TEST_${TESTVAR}%0;test avec des une clef contenant une variable
Check%65;Non unicite de la clef
Insert%8;La condition de selection de cle n'est pas valide
Insert%97;Aucune valeur a inserer n'est specifiee
Modify%8;La condition de selection de la cle n est pas valide
Modify%68;Aucune ligne trouvee a modifier
Modify%97;Aucune valeur a modifier n'est specifiee
Remove%68;Aucune ligne trouvee a supprimer
Replace%8;La condition de selection de la cle n'est pas valide
Replace%68;Aucune ligne trouvee a remplacer
Replace%97;Aucune valeur a remplacer n'est specifiee
generic%1;Impossible de trouver l'executable %s
generic%2;Impossible de trouver la table %s
generic%3;Impossible de trouver ou d'ouvrir le fichier de definition %s
generic%4;Impossible de trouver le fichier %s
generic%5;Le fichier de definition %s n'est pas valide
generic%6;La table %s est une table virtuelle
generic%7;La colonne %s n'existe pas
generic%8;La condition de selection n'est pas valide
generic%9;La chaine de definition %s n'est pas valide ou est absente
generic%10;Impossible d'ouvrir le fichier %s
generic%11;Impossible d'ecrire dans le fichier %s
generic%12;Impossible de supprimer le fichier %s
generic%13;Impossible de changer les droits sur le fichier %s
generic%14;Impossible de renommer/deplacer le fichier %s en %s
generic%15;Impossible de copier le fichier %s
generic%16;Erreur lors d'une ecriture dans le fichier %s
generic%17;La commande <%s> a echoue
generic%18;La variable racine BV_HOME ou TOOLS_HOME n'est pas exportee !
generic%19;L'evaluation de <%s> est incorrecte !
generic%20;L'option %s n'est pas valide
generic%21;Le nombre d'arguments est incorrect
generic%22;L'argument %s n'est pas valide
generic%23;Utilisation incorrecte de l'option -h
generic%24;Ligne de commande incorrecte
generic%25;Erreur lors d'une allocation de memoire %s
generic%26;Erreur lors d'une re-allocation de memoire %s
generic%27;Erreur lors du chargement de la librairie %s !
generic%28;Impossible de retrouver le symbole %s en librairie !
generic%29;Erreur lors de la fermeture de la librairie %s !
generic%30;Votre licence d'utilisation %s a expire !
generic%31;Le Hostid de la machine n'est pas valide !
generic%32;La licence n'est pas valide !
generic%33;Il n'y a pas de licence valide pour ce produit !
generic%34;Le nombre de clients pour ce produit est depasse !
generic%35;Le nom de fichier %s n'est pas valide
generic%36;Le fichier %s est verouille
generic%37;Impossible de poser un verrou sur le fichier %s
generic%38;Le delai maximum d'attente de deverouillage a ete atteint
generic%39;Le fichier %s n'est pas verouille
generic%40;Impossible de retirer le verrou du fichier %s
generic%41;Le nombre maximal de selections simultanees est depasse
generic%42;Le Handle d'une requete n'est pas valide
generic%43;Le nombre maximal de conditions est depasse
generic%44;Impossible de retrouver la librairie %s !
generic%45;Un Handle n'est pas valide
generic%46;Le nombre maximal de fichiers ouverts est depasse
generic%47;Le nombre maximal %s d'allocations de memoire est depasse
generic%48;Impossible de retrouver le fichier de menu %s
generic%49;Impossible de retrouver le dictionnaire graphique %s
generic%50;Erreur lors de l'execution de la fonction de log
generic%51;Erreur de type '%s' lors de la deconnexion Oracle !
generic%52;Impossible d'ecrire dans le fichier log %s
generic%53;Impossible de determiner le nom du traitement
generic%54;Le numero d'erreur est manquant
generic%55;Le message d'information est manquant
generic%56;Le numero d'erreur %s n'a pas de message associe
generic%57;Le numero d'erreur %s n'est pas correct
generic%58;Le type de message de log n'est pas correct
generic%59;Le nom de table %s n'est pas valide
generic%60;La colonne %s doit absolument contenir une valeur
generic%61;Il n'y a pas assez de valeurs par rapport au nombre de colonnes
generic%62;Il y a trop de valeurs par rapport au nombre de colonnes
generic%63;La valeur donnee pour la colonne %s n'est pas correcte.
generic%64;Le nom de la table n'est pas specifie
generic%65;Non unicite de la clef de la ligne a inserer
generic%66;Le groupe d'utilisateurs %s n'existe pas
generic%67;Impossible de remplacer une ligne sur une table sans clef
generic%68;Aucune ligne trouvee
generic%69;Entete de definition invalide !
generic%70;Variables d'environnement SEP ou FORMAT absente !
generic%71;Il n'y a pas de lignes en entree stdin !
generic%72;Impossible d'ouvrir le fichier %s en ecriture !
generic%73;Impossible d'ouvrir le fichier %s en lecture !
generic%74;Impossible d'ouvrir le fichier %s en lecture et ecriture !
generic%75;Erreur generique Oracle : %s
generic%76;Erreur de syntaxe dans la requete SQL generee : %s
generic%77;Une valeur a inserer est trop large pour sa colonne !
generic%78;Impossible de se connecter a Oracle avec l'utilisateur %s
generic%79;Impossible de locker la table %s. Ressource deja occupee !
generic%80;La requete interne SQL s'est terminee en erreur !
generic%81;Le nouveau separateur n'est pas specifie !
generic%82;Le nombre maximal de colonnes %s du dictionnaire est depasse !
generic%83;La colonne %s apparait plusieurs fois dans le dictionnaire !
generic%84;La source de donnees %s du dictionnaire est invalide !
generic%85;La table %s ne peut-etre verouillee ou deverouillee !
generic%86;Vous ne pouvez pas remplacer une cle !
generic%87;Impossible de creer un nouveau processus %s !
generic%88;Le nombre maximal de tables %s est depasse
generic%89;Option ou suffixe de recherche invalide !
generic%90;Pas de librairie chargee pour acceder a la base de donnees !
generic%91;Variable d'environnement %s manquante ou non exportee !
generic%92;Parametre <+ recent que> inferieur au parametre <+ vieux que>.
generic%93;Le type de la colonne %s est invalide !
generic%94;Impossible de retrouver le formulaire %s
generic%95;Impossible de retrouver le panneau de commandes %s.
generic%96;L'operateur de selection est incorrect !
generic%97;Aucune valeur donnee
generic%98;La taille maximale %s d'une ligne est depassee !
generic%99;Le champ %s est mal decrit dans la table %s
generic%100;%s
generic%101;Le parametre %s n'est pas un chiffre
generic%102;L'utilisateur %s n'existe pas
generic%103;La cle de reference de la contrainte sur %s est incorrecte.
generic%104;Erreur lors du delete sur %s
generic%105;La variable %s n'est pas du bon type
generic%106;Probleme lors du chargement de l'environnement %s
generic%107;Environnement %s non accessible
generic%108;Probleme pour acceder a la table %s
generic%109;La table %s n'existe pas ou n'est pas accessible
generic%110;Impossible de retrouver l'objet %s
generic%111;La table %s existe sous plusieurs schemas
generic%112;Probleme pour recuperer les contraintes de %s
generic%113;Erreur lors du disable de contraintes de %s
generic%114;Erreur lors de l'enable de contraintes de %s
generic%115;Erreur lors du chargement de la table %s
generic%116;Des enregistrements ont ete rejetes pour la table %s
generic%117;La contrainte %s est invalide !
generic%118;Le nombre maximal %s de cles etrangeres est depasse.
generic%119;Le nombre maximal %s de contraintes est depasse.
generic%120;Impossible de creer le fichier %s
generic%121;La table %s n'est pas une table de reference.
generic%122;La table %s existe sous plusieurs cles etrang�res.
generic%123;Les droits sur le fichier %s sont incorrects.
generic%124;Probleme pour recuperer les informations '%s' de la Machine %s.
generic%125;Le type de la licence est invalide.
generic%126;L'utilisateur %s n'est pas administrateur du systeme.
generic%127;Les colonnes %s doivent absolument contenir une valeur.
generic%128;La table %s ne possede pas de cle primaire.
generic%129;La valeur d'une cle primaire ne peut-etre nulle.
generic%130;Options de commande %s incompatibles
generic%131;Le tri de s�l�ction '%s' est invalide.
generic%132;Le format de la date '%s' est invalide.
generic%133;Les el�ments % de la date doivent �tre s�par�s par un caract�re.
generic%134;La date '%s' ne correspond pas au format %s.
generic%148;Vous n'avez pas les droits %s.
generic%149;Probleme d'environnement %s
generic%150;Mot de Passe inconnu pour le user %s sur la base $ORACLE_SID
generic%151;Variables inconnues BV_ORAUSER et/ou BV_ORAPASS
generic%152;L'intance %s est invalide ou non demarr�e.
V1_alim_30_motcle%0001;ECHEC ce l'Insert Arg de %s dans t_me_alma
V1_alim_30_motcle%0002;Argument de la methode %s non declare dans me_alma
V1_alim_30_motcle%0003;Rang de l'argument de la methode %s incoherent
V1_alim_30_motcle%0004;ECHEC de l'insertion du mot cle %s dans t_me_ma
V1_alim_40_meth%0001;Le mot cle d'action %s n'existe pas
V1_alim_40_meth%0002;L'Insertion de la methode physique %s a echoue
V1_alim_40_meth%0003;L'Insertion de la variable interne %s a echoue
V1_alim_40_meth%0004;L'Insertion du type physique %s a echoue
PC_CHGSTAT_SERV%0004;Aucune instance n'est associee a l'application %s
generic%301;Le module applicatif %s n'est pas ou mal declar�.
generic%302;L'instance de service %s ne semble pas exister.
generic%303;Le script fils <%s> a retourne un warning
generic%304;Le script fils <%s> a retourne une erreur bloquante
generic%305;Le script fils <%s> a retourne une erreur fatale
generic%306;Le script fils <%s> a retourne un code d'erreur errone %s
generic%308;Erreur a l'execution de %s
generic%309;Le service %s '%s' n'existe pas.
generic%310;Le service %s '%s' est deja demarre.
generic%311;Le service %s '%s' est deja arrete.
generic%312;Le service %s '%s' n'a pas demarre correctement.
generic%313;Le service %s '%s' ne s'est pas arrete correctement.
generic%314;Le service %s '%s' n'est pas ou mal declar�.
generic%315;Le module applicatif %s ne poss�de aucune instance de service.
generic%316;La ressource %s '%s' n'est pas ou mal declar�.
generic%317;Impossible de choisir un type pour le Service %s '%s'.
generic%318;Impossible de choisir un type de service pour le I-CLES %s.
generic%319;La table %s n'est pas collectable.
generic%320;Le type de ressource %s n'est pas ou mal d�clar�.
generic%321;Le Type de Service %s du I-CLES %s n'existe pas.
generic%401;Le repertoire %s n'existe pas
generic%402;Impossible de creer le repertoire %s
generic%403;Impossible d'ecrire dans le repertoire %s
generic%404;Impossible de lire le contenu du repertoire %s
generic%405;Le fichier %s n'existe pas ou est vide
generic%406;Le fichier %s existe deja
generic%408;Le fichier %s n'est pas au format %s
generic%409;Erreur lors de l'initialisation du fichier %s
generic%410;Probleme lors de la restauration/decompression de %s
generic%411;Probleme lors de la decompression de %s
generic%412;Probleme lors de la compression de %s
generic%413;Probleme lors de la securisation/compression de %s
generic%414;Le Lecteur %s doit etre NO REWIND pour avancer/reculer
generic%415;Le device %s n'existe pas ou est indisponible
generic%416;Probleme lors de la creation du lien vers %s
generic%417;Le lecteur %s est inaccessible
generic%420;Impossible d'aller sous le r�pertoire '%s'.
ME_CREATE_SYNORA%0001;Probleme a la creation du Synonyme %s
ME_DROP_SYNORA%0001;Probleme a la suppression du Synonyme %s
ME_LOAD_TABORA%0001;Echec du Load sqlldr de %s
ME_RESTORE_TABORA%0001;Erreur lors de la restauration de la table %s
ME_SECURE_TABORA%0001;Impossible de recuperer la taille du tablespace %s
ME_SECURE_TABORA%0002;Impossible de recuperer la taille de la table %s
ME_SECURE_TABORA%0003;Erreur lors de la securisation de la table %s
ME_SECURE_TABORA%0004;Impossible de recuperer la taille de la sauvegarde
ME_SECURE_TABORA%0365;Probleme lors de la mise a jour de la table %s
ME_TRUNC_TABORA%176;Probleme de truncate sur %s (Contrainte type P referencee) 
PC_BACK_TBSORA%137;Probleme pour mettre le TBSPACE %s en BEGIN BACKUP
PC_BACK_TBSORA%138;Probleme pour mettre le TBSPACE %s en END BACKUP
PC_BACK_TBSORA%139;Probleme pour manipuler le TBSPACE %s
PC_LISTBACK_ARCHORA%0001;Il manque la sequence d'archives %s pour la base %s
PC_LISTBACK_ARCHORA%0002;Il n'existe pas d'archives commen�ant a la sequence %s.
PC_LISTBACK_CTRLORA%128;Impossible d'interroger les logfiles de %s
PC_LISTBACK_CTRLORA%132;Impossible d'interroger les controlfiles de %s
PC_LISTID_INSORA%182;Impossible de trouver la Base du user %s
PC_SWITCH_LOGORA%127;Probleme lors du switch des logfiles de %s
PC_SWITCH_LOGORA%128;Impossible d'interroger les logfiles pour %s
generic%501;L'instance Oracle %s n'est pas demarree
generic%502;L'instance Oracle %s n'est pas arretee
generic%503;%s n'est pas un mode d'arret Oracle valide
generic%504;%s n'est pas un mode de demarrage Oracle valide
generic%505;La base Oracle %s existe deja dans /etc/oratab
generic%506;Impossible de retrouver l'environnement de l'instance Oracle %s
generic%507;Impossible de retrouver l'init file de la base %s
generic%508;Le fichier de config de %s n'est pas renseigne dans l'initfile
generic%509;Les controlfiles de %s ne sont pas renseignes dans les initfiles
generic%510;Les parametres d'archive %s n'existent pas dans les initfiles
generic%511;Parametre log_archive_dest de %s non defini dans les initfiles
generic%512;Parametre log_archive_format de %s non defini dans les initfiles
generic%513;L'archivage de %s n'est pas demarre correctement
generic%514;L'archivage de %s n'est pas arrete correctement
generic%515;Script SQL %s non accessible
generic%517;Le script SQL %s ne s'est pas execute correctement
generic%518;Probleme lors de la suppression de la table %s 
generic%519;Probleme a l'execution du delete ou truncate de %s sur $ORACLE_SID
generic%520;Aucun Archive Oracle pour la Base %s
PC_INITF_SQLNET%004;La configuration SqlNet %s de %s est introuvable
FT_LISTLST_SQLNET%346;Aucun Listener convenablement declare dans %s
FT_LIST_TNSNAME%346;Aucun Service TNS convenablement declare dans %s
PC_ENV_SQLNET%506;Impossible de trouver l'environnement de l'instance Sqlnet %s
PC_LISTID_SQLNET%182;Impossible de trouver le Noyau SqlNet du user %s
PC_STAT_TNSNAME%001;Le service TNS %s n'est pas decrit
PC_STAT_TNSNAME%002;Il n'y a pas de listener demarre servant le service TNS %s
PC_STAT_TNSNAME%003;Erreur de configuration de l'adresse du service TNS %s

EXPECTED_OUTPUT
chomp $expected_string;
$expected_error = << 'EXPECTED_ERRSTD';

EXPECTED_ERRSTD
chomp $expected_error;

run3('Select -s from error_messages | Formate_File -s\\;/% -n 2 -', undef, \$return_string, \$return_error);

$home=quotemeta($ENV{TOOLS_HOME});
$return_string =~ s/$home/TOOLS_HOME/g;
$return_error =~ s/$home/TOOLS_HOME/g;

if ( $? == -1 ) {
	BAIL_OUT("<".'Select -s from error_messages | Formate_File -s\\;/% -n 2 -'."> retourne -1");
}
$return_code = $? >> 8;

is ( $return_code ,$expected_code , "<".'Select -s from error_messages | Formate_File -s\\;/% -n 2 -'."> return code $expected_code");
is ( $return_string ,$expected_string , "<".'Select -s from error_messages | Formate_File -s\\;/% -n 2 -'."> output <".q{TEST%1;tes...}.">");

# test si a renvoyer une erreur ou non
is ( $return_error ne '', $expected_error ne '', "<".'Select -s from error_messages | Formate_File -s\\;/% -n 2 -'."> errstd") or diag($return_error);


##################
# Select -s from error_messages | Formate_File -s\;/% -n 3 -
##################

$expected_code = 0;
$expected_string = <<'EXPECTED_OUTPUT';
TEST%1%test sans quote
TEST%2%test avec ' des ' quote
TEST%3%test avec " des " double quote
TEST%4%test avec \" des \' quote echappees
TEST%5%test avec \\ echappements \n
TEST%6%test avec trop de ; separ;ateurs;
TEST%7%test avec des $variables $TESTVAR
TEST%8%test avec des $variables $(echo "commande evaluee")
TEST%9%test avec des $variables `echo "commande evaluee"`
TEST_${TESTVAR}%0%test avec des une clef contenant une variable
Check%65%Non unicite de la clef
Insert%8%La condition de selection de cle n'est pas valide
Insert%97%Aucune valeur a inserer n'est specifiee
Modify%8%La condition de selection de la cle n est pas valide
Modify%68%Aucune ligne trouvee a modifier
Modify%97%Aucune valeur a modifier n'est specifiee
Remove%68%Aucune ligne trouvee a supprimer
Replace%8%La condition de selection de la cle n'est pas valide
Replace%68%Aucune ligne trouvee a remplacer
Replace%97%Aucune valeur a remplacer n'est specifiee
generic%1%Impossible de trouver l'executable %s
generic%2%Impossible de trouver la table %s
generic%3%Impossible de trouver ou d'ouvrir le fichier de definition %s
generic%4%Impossible de trouver le fichier %s
generic%5%Le fichier de definition %s n'est pas valide
generic%6%La table %s est une table virtuelle
generic%7%La colonne %s n'existe pas
generic%8%La condition de selection n'est pas valide
generic%9%La chaine de definition %s n'est pas valide ou est absente
generic%10%Impossible d'ouvrir le fichier %s
generic%11%Impossible d'ecrire dans le fichier %s
generic%12%Impossible de supprimer le fichier %s
generic%13%Impossible de changer les droits sur le fichier %s
generic%14%Impossible de renommer/deplacer le fichier %s en %s
generic%15%Impossible de copier le fichier %s
generic%16%Erreur lors d'une ecriture dans le fichier %s
generic%17%La commande <%s> a echoue
generic%18%La variable racine BV_HOME ou TOOLS_HOME n'est pas exportee !
generic%19%L'evaluation de <%s> est incorrecte !
generic%20%L'option %s n'est pas valide
generic%21%Le nombre d'arguments est incorrect
generic%22%L'argument %s n'est pas valide
generic%23%Utilisation incorrecte de l'option -h
generic%24%Ligne de commande incorrecte
generic%25%Erreur lors d'une allocation de memoire %s
generic%26%Erreur lors d'une re-allocation de memoire %s
generic%27%Erreur lors du chargement de la librairie %s !
generic%28%Impossible de retrouver le symbole %s en librairie !
generic%29%Erreur lors de la fermeture de la librairie %s !
generic%30%Votre licence d'utilisation %s a expire !
generic%31%Le Hostid de la machine n'est pas valide !
generic%32%La licence n'est pas valide !
generic%33%Il n'y a pas de licence valide pour ce produit !
generic%34%Le nombre de clients pour ce produit est depasse !
generic%35%Le nom de fichier %s n'est pas valide
generic%36%Le fichier %s est verouille
generic%37%Impossible de poser un verrou sur le fichier %s
generic%38%Le delai maximum d'attente de deverouillage a ete atteint
generic%39%Le fichier %s n'est pas verouille
generic%40%Impossible de retirer le verrou du fichier %s
generic%41%Le nombre maximal de selections simultanees est depasse
generic%42%Le Handle d'une requete n'est pas valide
generic%43%Le nombre maximal de conditions est depasse
generic%44%Impossible de retrouver la librairie %s !
generic%45%Un Handle n'est pas valide
generic%46%Le nombre maximal de fichiers ouverts est depasse
generic%47%Le nombre maximal %s d'allocations de memoire est depasse
generic%48%Impossible de retrouver le fichier de menu %s
generic%49%Impossible de retrouver le dictionnaire graphique %s
generic%50%Erreur lors de l'execution de la fonction de log
generic%51%Erreur de type '%s' lors de la deconnexion Oracle !
generic%52%Impossible d'ecrire dans le fichier log %s
generic%53%Impossible de determiner le nom du traitement
generic%54%Le numero d'erreur est manquant
generic%55%Le message d'information est manquant
generic%56%Le numero d'erreur %s n'a pas de message associe
generic%57%Le numero d'erreur %s n'est pas correct
generic%58%Le type de message de log n'est pas correct
generic%59%Le nom de table %s n'est pas valide
generic%60%La colonne %s doit absolument contenir une valeur
generic%61%Il n'y a pas assez de valeurs par rapport au nombre de colonnes
generic%62%Il y a trop de valeurs par rapport au nombre de colonnes
generic%63%La valeur donnee pour la colonne %s n'est pas correcte.
generic%64%Le nom de la table n'est pas specifie
generic%65%Non unicite de la clef de la ligne a inserer
generic%66%Le groupe d'utilisateurs %s n'existe pas
generic%67%Impossible de remplacer une ligne sur une table sans clef
generic%68%Aucune ligne trouvee
generic%69%Entete de definition invalide !
generic%70%Variables d'environnement SEP ou FORMAT absente !
generic%71%Il n'y a pas de lignes en entree stdin !
generic%72%Impossible d'ouvrir le fichier %s en ecriture !
generic%73%Impossible d'ouvrir le fichier %s en lecture !
generic%74%Impossible d'ouvrir le fichier %s en lecture et ecriture !
generic%75%Erreur generique Oracle : %s
generic%76%Erreur de syntaxe dans la requete SQL generee : %s
generic%77%Une valeur a inserer est trop large pour sa colonne !
generic%78%Impossible de se connecter a Oracle avec l'utilisateur %s
generic%79%Impossible de locker la table %s. Ressource deja occupee !
generic%80%La requete interne SQL s'est terminee en erreur !
generic%81%Le nouveau separateur n'est pas specifie !
generic%82%Le nombre maximal de colonnes %s du dictionnaire est depasse !
generic%83%La colonne %s apparait plusieurs fois dans le dictionnaire !
generic%84%La source de donnees %s du dictionnaire est invalide !
generic%85%La table %s ne peut-etre verouillee ou deverouillee !
generic%86%Vous ne pouvez pas remplacer une cle !
generic%87%Impossible de creer un nouveau processus %s !
generic%88%Le nombre maximal de tables %s est depasse
generic%89%Option ou suffixe de recherche invalide !
generic%90%Pas de librairie chargee pour acceder a la base de donnees !
generic%91%Variable d'environnement %s manquante ou non exportee !
generic%92%Parametre <+ recent que> inferieur au parametre <+ vieux que>.
generic%93%Le type de la colonne %s est invalide !
generic%94%Impossible de retrouver le formulaire %s
generic%95%Impossible de retrouver le panneau de commandes %s.
generic%96%L'operateur de selection est incorrect !
generic%97%Aucune valeur donnee
generic%98%La taille maximale %s d'une ligne est depassee !
generic%99%Le champ %s est mal decrit dans la table %s
generic%100%%s
generic%101%Le parametre %s n'est pas un chiffre
generic%102%L'utilisateur %s n'existe pas
generic%103%La cle de reference de la contrainte sur %s est incorrecte.
generic%104%Erreur lors du delete sur %s
generic%105%La variable %s n'est pas du bon type
generic%106%Probleme lors du chargement de l'environnement %s
generic%107%Environnement %s non accessible
generic%108%Probleme pour acceder a la table %s
generic%109%La table %s n'existe pas ou n'est pas accessible
generic%110%Impossible de retrouver l'objet %s
generic%111%La table %s existe sous plusieurs schemas
generic%112%Probleme pour recuperer les contraintes de %s
generic%113%Erreur lors du disable de contraintes de %s
generic%114%Erreur lors de l'enable de contraintes de %s
generic%115%Erreur lors du chargement de la table %s
generic%116%Des enregistrements ont ete rejetes pour la table %s
generic%117%La contrainte %s est invalide !
generic%118%Le nombre maximal %s de cles etrangeres est depasse.
generic%119%Le nombre maximal %s de contraintes est depasse.
generic%120%Impossible de creer le fichier %s
generic%121%La table %s n'est pas une table de reference.
generic%122%La table %s existe sous plusieurs cles etrang�res.
generic%123%Les droits sur le fichier %s sont incorrects.
generic%124%Probleme pour recuperer les informations '%s' de la Machine %s.
generic%125%Le type de la licence est invalide.
generic%126%L'utilisateur %s n'est pas administrateur du systeme.
generic%127%Les colonnes %s doivent absolument contenir une valeur.
generic%128%La table %s ne possede pas de cle primaire.
generic%129%La valeur d'une cle primaire ne peut-etre nulle.
generic%130%Options de commande %s incompatibles
generic%131%Le tri de s�l�ction '%s' est invalide.
generic%132%Le format de la date '%s' est invalide.
generic%133%Les el�ments % de la date doivent �tre s�par�s par un caract�re.
generic%134%La date '%s' ne correspond pas au format %s.
generic%148%Vous n'avez pas les droits %s.
generic%149%Probleme d'environnement %s
generic%150%Mot de Passe inconnu pour le user %s sur la base $ORACLE_SID
generic%151%Variables inconnues BV_ORAUSER et/ou BV_ORAPASS
generic%152%L'intance %s est invalide ou non demarr�e.
V1_alim_30_motcle%0001%ECHEC ce l'Insert Arg de %s dans t_me_alma
V1_alim_30_motcle%0002%Argument de la methode %s non declare dans me_alma
V1_alim_30_motcle%0003%Rang de l'argument de la methode %s incoherent
V1_alim_30_motcle%0004%ECHEC de l'insertion du mot cle %s dans t_me_ma
V1_alim_40_meth%0001%Le mot cle d'action %s n'existe pas
V1_alim_40_meth%0002%L'Insertion de la methode physique %s a echoue
V1_alim_40_meth%0003%L'Insertion de la variable interne %s a echoue
V1_alim_40_meth%0004%L'Insertion du type physique %s a echoue
PC_CHGSTAT_SERV%0004%Aucune instance n'est associee a l'application %s
generic%301%Le module applicatif %s n'est pas ou mal declar�.
generic%302%L'instance de service %s ne semble pas exister.
generic%303%Le script fils <%s> a retourne un warning
generic%304%Le script fils <%s> a retourne une erreur bloquante
generic%305%Le script fils <%s> a retourne une erreur fatale
generic%306%Le script fils <%s> a retourne un code d'erreur errone %s
generic%308%Erreur a l'execution de %s
generic%309%Le service %s '%s' n'existe pas.
generic%310%Le service %s '%s' est deja demarre.
generic%311%Le service %s '%s' est deja arrete.
generic%312%Le service %s '%s' n'a pas demarre correctement.
generic%313%Le service %s '%s' ne s'est pas arrete correctement.
generic%314%Le service %s '%s' n'est pas ou mal declar�.
generic%315%Le module applicatif %s ne poss�de aucune instance de service.
generic%316%La ressource %s '%s' n'est pas ou mal declar�.
generic%317%Impossible de choisir un type pour le Service %s '%s'.
generic%318%Impossible de choisir un type de service pour le I-CLES %s.
generic%319%La table %s n'est pas collectable.
generic%320%Le type de ressource %s n'est pas ou mal d�clar�.
generic%321%Le Type de Service %s du I-CLES %s n'existe pas.
generic%401%Le repertoire %s n'existe pas
generic%402%Impossible de creer le repertoire %s
generic%403%Impossible d'ecrire dans le repertoire %s
generic%404%Impossible de lire le contenu du repertoire %s
generic%405%Le fichier %s n'existe pas ou est vide
generic%406%Le fichier %s existe deja
generic%408%Le fichier %s n'est pas au format %s
generic%409%Erreur lors de l'initialisation du fichier %s
generic%410%Probleme lors de la restauration/decompression de %s
generic%411%Probleme lors de la decompression de %s
generic%412%Probleme lors de la compression de %s
generic%413%Probleme lors de la securisation/compression de %s
generic%414%Le Lecteur %s doit etre NO REWIND pour avancer/reculer
generic%415%Le device %s n'existe pas ou est indisponible
generic%416%Probleme lors de la creation du lien vers %s
generic%417%Le lecteur %s est inaccessible
generic%420%Impossible d'aller sous le r�pertoire '%s'.
ME_CREATE_SYNORA%0001%Probleme a la creation du Synonyme %s
ME_DROP_SYNORA%0001%Probleme a la suppression du Synonyme %s
ME_LOAD_TABORA%0001%Echec du Load sqlldr de %s
ME_RESTORE_TABORA%0001%Erreur lors de la restauration de la table %s
ME_SECURE_TABORA%0001%Impossible de recuperer la taille du tablespace %s
ME_SECURE_TABORA%0002%Impossible de recuperer la taille de la table %s
ME_SECURE_TABORA%0003%Erreur lors de la securisation de la table %s
ME_SECURE_TABORA%0004%Impossible de recuperer la taille de la sauvegarde
ME_SECURE_TABORA%0365%Probleme lors de la mise a jour de la table %s
ME_TRUNC_TABORA%176%Probleme de truncate sur %s (Contrainte type P referencee) 
PC_BACK_TBSORA%137%Probleme pour mettre le TBSPACE %s en BEGIN BACKUP
PC_BACK_TBSORA%138%Probleme pour mettre le TBSPACE %s en END BACKUP
PC_BACK_TBSORA%139%Probleme pour manipuler le TBSPACE %s
PC_LISTBACK_ARCHORA%0001%Il manque la sequence d'archives %s pour la base %s
PC_LISTBACK_ARCHORA%0002%Il n'existe pas d'archives commen�ant a la sequence %s.
PC_LISTBACK_CTRLORA%128%Impossible d'interroger les logfiles de %s
PC_LISTBACK_CTRLORA%132%Impossible d'interroger les controlfiles de %s
PC_LISTID_INSORA%182%Impossible de trouver la Base du user %s
PC_SWITCH_LOGORA%127%Probleme lors du switch des logfiles de %s
PC_SWITCH_LOGORA%128%Impossible d'interroger les logfiles pour %s
generic%501%L'instance Oracle %s n'est pas demarree
generic%502%L'instance Oracle %s n'est pas arretee
generic%503%%s n'est pas un mode d'arret Oracle valide
generic%504%%s n'est pas un mode de demarrage Oracle valide
generic%505%La base Oracle %s existe deja dans /etc/oratab
generic%506%Impossible de retrouver l'environnement de l'instance Oracle %s
generic%507%Impossible de retrouver l'init file de la base %s
generic%508%Le fichier de config de %s n'est pas renseigne dans l'initfile
generic%509%Les controlfiles de %s ne sont pas renseignes dans les initfiles
generic%510%Les parametres d'archive %s n'existent pas dans les initfiles
generic%511%Parametre log_archive_dest de %s non defini dans les initfiles
generic%512%Parametre log_archive_format de %s non defini dans les initfiles
generic%513%L'archivage de %s n'est pas demarre correctement
generic%514%L'archivage de %s n'est pas arrete correctement
generic%515%Script SQL %s non accessible
generic%517%Le script SQL %s ne s'est pas execute correctement
generic%518%Probleme lors de la suppression de la table %s 
generic%519%Probleme a l'execution du delete ou truncate de %s sur $ORACLE_SID
generic%520%Aucun Archive Oracle pour la Base %s
PC_INITF_SQLNET%004%La configuration SqlNet %s de %s est introuvable
FT_LISTLST_SQLNET%346%Aucun Listener convenablement declare dans %s
FT_LIST_TNSNAME%346%Aucun Service TNS convenablement declare dans %s
PC_ENV_SQLNET%506%Impossible de trouver l'environnement de l'instance Sqlnet %s
PC_LISTID_SQLNET%182%Impossible de trouver le Noyau SqlNet du user %s
PC_STAT_TNSNAME%001%Le service TNS %s n'est pas decrit
PC_STAT_TNSNAME%002%Il n'y a pas de listener demarre servant le service TNS %s
PC_STAT_TNSNAME%003%Erreur de configuration de l'adresse du service TNS %s

EXPECTED_OUTPUT
chomp $expected_string;
$expected_error = << 'EXPECTED_ERRSTD';

EXPECTED_ERRSTD
chomp $expected_error;

run3('Select -s from error_messages | Formate_File -s\\;/% -n 3 -', undef, \$return_string, \$return_error);

$home=quotemeta($ENV{TOOLS_HOME});
$return_string =~ s/$home/TOOLS_HOME/g;
$return_error =~ s/$home/TOOLS_HOME/g;

if ( $? == -1 ) {
	BAIL_OUT("<".'Select -s from error_messages | Formate_File -s\\;/% -n 3 -'."> retourne -1");
}
$return_code = $? >> 8;

is ( $return_code ,$expected_code , "<".'Select -s from error_messages | Formate_File -s\\;/% -n 3 -'."> return code $expected_code");
is ( $return_string ,$expected_string , "<".'Select -s from error_messages | Formate_File -s\\;/% -n 3 -'."> output <".q{TEST%1%tes...}.">");

# test si a renvoyer une erreur ou non
is ( $return_error ne '', $expected_error ne '', "<".'Select -s from error_messages | Formate_File -s\\;/% -n 3 -'."> errstd") or diag($return_error);


##################
# Select -s from error_messages | Formate_File -s\;/% -n 4 -
##################

$expected_code = 0;
$expected_string = <<'EXPECTED_OUTPUT';
TEST%1%test sans quote%test sans quote
TEST%2%test avec ' des ' quote%test avec ' des ' quote
TEST%3%test avec " des " double quote%test avec " des " double quote
TEST%4%test avec \" des \' quote echappees%test avec \" des \' quote echappees
TEST%5%test avec \\ echappements \n%test avec \\ echappements \n
TEST%6%test avec trop de % separ;ateurs;
TEST%7%test avec des $variables $TESTVAR%test avec des $variables $TESTVAR
TEST%8%test avec des $variables $(echo "commande evaluee")%test avec des $variables $(echo "commande evaluee")
TEST%9%test avec des $variables `echo "commande evaluee"`%test avec des $variables `echo "commande evaluee"`
TEST_${TESTVAR}%0%test avec des une clef contenant une variable%test avec des une clef contenant une variable
Check%65%Non unicite de la clef%Non unicite de la clef
Insert%8%La condition de selection de cle n'est pas valide%La condition de selection de cle n'est pas valide
Insert%97%Aucune valeur a inserer n'est specifiee%Aucune valeur a inserer n'est specifiee
Modify%8%La condition de selection de la cle n est pas valide%La condition de selection de la cle n est pas valide
Modify%68%Aucune ligne trouvee a modifier%Aucune ligne trouvee a modifier
Modify%97%Aucune valeur a modifier n'est specifiee%Aucune valeur a modifier n'est specifiee
Remove%68%Aucune ligne trouvee a supprimer%Aucune ligne trouvee a supprimer
Replace%8%La condition de selection de la cle n'est pas valide%La condition de selection de la cle n'est pas valide
Replace%68%Aucune ligne trouvee a remplacer%Aucune ligne trouvee a remplacer
Replace%97%Aucune valeur a remplacer n'est specifiee%Aucune valeur a remplacer n'est specifiee
generic%1%Impossible de trouver l'executable %s%Impossible de trouver l'executable %s
generic%2%Impossible de trouver la table %s%Impossible de trouver la table %s
generic%3%Impossible de trouver ou d'ouvrir le fichier de definition %s%Impossible de trouver ou d'ouvrir le fichier de definition %s
generic%4%Impossible de trouver le fichier %s%Impossible de trouver le fichier %s
generic%5%Le fichier de definition %s n'est pas valide%Le fichier de definition %s n'est pas valide
generic%6%La table %s est une table virtuelle%La table %s est une table virtuelle
generic%7%La colonne %s n'existe pas%La colonne %s n'existe pas
generic%8%La condition de selection n'est pas valide%La condition de selection n'est pas valide
generic%9%La chaine de definition %s n'est pas valide ou est absente%La chaine de definition %s n'est pas valide ou est absente
generic%10%Impossible d'ouvrir le fichier %s%Impossible d'ouvrir le fichier %s
generic%11%Impossible d'ecrire dans le fichier %s%Impossible d'ecrire dans le fichier %s
generic%12%Impossible de supprimer le fichier %s%Impossible de supprimer le fichier %s
generic%13%Impossible de changer les droits sur le fichier %s%Impossible de changer les droits sur le fichier %s
generic%14%Impossible de renommer/deplacer le fichier %s en %s%Impossible de renommer/deplacer le fichier %s en %s
generic%15%Impossible de copier le fichier %s%Impossible de copier le fichier %s
generic%16%Erreur lors d'une ecriture dans le fichier %s%Erreur lors d'une ecriture dans le fichier %s
generic%17%La commande <%s> a echoue%La commande <%s> a echoue
generic%18%La variable racine BV_HOME ou TOOLS_HOME n'est pas exportee !%La variable racine BV_HOME ou TOOLS_HOME n'est pas exportee !
generic%19%L'evaluation de <%s> est incorrecte !%L'evaluation de <%s> est incorrecte !
generic%20%L'option %s n'est pas valide%L'option %s n'est pas valide
generic%21%Le nombre d'arguments est incorrect%Le nombre d'arguments est incorrect
generic%22%L'argument %s n'est pas valide%L'argument %s n'est pas valide
generic%23%Utilisation incorrecte de l'option -h%Utilisation incorrecte de l'option -h
generic%24%Ligne de commande incorrecte%Ligne de commande incorrecte
generic%25%Erreur lors d'une allocation de memoire %s%Erreur lors d'une allocation de memoire %s
generic%26%Erreur lors d'une re-allocation de memoire %s%Erreur lors d'une re-allocation de memoire %s
generic%27%Erreur lors du chargement de la librairie %s !%Erreur lors du chargement de la librairie %s !
generic%28%Impossible de retrouver le symbole %s en librairie !%Impossible de retrouver le symbole %s en librairie !
generic%29%Erreur lors de la fermeture de la librairie %s !%Erreur lors de la fermeture de la librairie %s !
generic%30%Votre licence d'utilisation %s a expire !%Votre licence d'utilisation %s a expire !
generic%31%Le Hostid de la machine n'est pas valide !%Le Hostid de la machine n'est pas valide !
generic%32%La licence n'est pas valide !%La licence n'est pas valide !
generic%33%Il n'y a pas de licence valide pour ce produit !%Il n'y a pas de licence valide pour ce produit !
generic%34%Le nombre de clients pour ce produit est depasse !%Le nombre de clients pour ce produit est depasse !
generic%35%Le nom de fichier %s n'est pas valide%Le nom de fichier %s n'est pas valide
generic%36%Le fichier %s est verouille%Le fichier %s est verouille
generic%37%Impossible de poser un verrou sur le fichier %s%Impossible de poser un verrou sur le fichier %s
generic%38%Le delai maximum d'attente de deverouillage a ete atteint%Le delai maximum d'attente de deverouillage a ete atteint
generic%39%Le fichier %s n'est pas verouille%Le fichier %s n'est pas verouille
generic%40%Impossible de retirer le verrou du fichier %s%Impossible de retirer le verrou du fichier %s
generic%41%Le nombre maximal de selections simultanees est depasse%Le nombre maximal de selections simultanees est depasse
generic%42%Le Handle d'une requete n'est pas valide%Le Handle d'une requete n'est pas valide
generic%43%Le nombre maximal de conditions est depasse%Le nombre maximal de conditions est depasse
generic%44%Impossible de retrouver la librairie %s !%Impossible de retrouver la librairie %s !
generic%45%Un Handle n'est pas valide%Un Handle n'est pas valide
generic%46%Le nombre maximal de fichiers ouverts est depasse%Le nombre maximal de fichiers ouverts est depasse
generic%47%Le nombre maximal %s d'allocations de memoire est depasse%Le nombre maximal %s d'allocations de memoire est depasse
generic%48%Impossible de retrouver le fichier de menu %s%Impossible de retrouver le fichier de menu %s
generic%49%Impossible de retrouver le dictionnaire graphique %s%Impossible de retrouver le dictionnaire graphique %s
generic%50%Erreur lors de l'execution de la fonction de log%Erreur lors de l'execution de la fonction de log
generic%51%Erreur de type '%s' lors de la deconnexion Oracle !%Erreur de type '%s' lors de la deconnexion Oracle !
generic%52%Impossible d'ecrire dans le fichier log %s%Impossible d'ecrire dans le fichier log %s
generic%53%Impossible de determiner le nom du traitement%Impossible de determiner le nom du traitement
generic%54%Le numero d'erreur est manquant%Le numero d'erreur est manquant
generic%55%Le message d'information est manquant%Le message d'information est manquant
generic%56%Le numero d'erreur %s n'a pas de message associe%Le numero d'erreur %s n'a pas de message associe
generic%57%Le numero d'erreur %s n'est pas correct%Le numero d'erreur %s n'est pas correct
generic%58%Le type de message de log n'est pas correct%Le type de message de log n'est pas correct
generic%59%Le nom de table %s n'est pas valide%Le nom de table %s n'est pas valide
generic%60%La colonne %s doit absolument contenir une valeur%La colonne %s doit absolument contenir une valeur
generic%61%Il n'y a pas assez de valeurs par rapport au nombre de colonnes%Il n'y a pas assez de valeurs par rapport au nombre de colonnes
generic%62%Il y a trop de valeurs par rapport au nombre de colonnes%Il y a trop de valeurs par rapport au nombre de colonnes
generic%63%La valeur donnee pour la colonne %s n'est pas correcte.%La valeur donnee pour la colonne %s n'est pas correcte.
generic%64%Le nom de la table n'est pas specifie%Le nom de la table n'est pas specifie
generic%65%Non unicite de la clef de la ligne a inserer%Non unicite de la clef de la ligne a inserer
generic%66%Le groupe d'utilisateurs %s n'existe pas%Le groupe d'utilisateurs %s n'existe pas
generic%67%Impossible de remplacer une ligne sur une table sans clef%Impossible de remplacer une ligne sur une table sans clef
generic%68%Aucune ligne trouvee%Aucune ligne trouvee
generic%69%Entete de definition invalide !%Entete de definition invalide !
generic%70%Variables d'environnement SEP ou FORMAT absente !%Variables d'environnement SEP ou FORMAT absente !
generic%71%Il n'y a pas de lignes en entree stdin !%Il n'y a pas de lignes en entree stdin !
generic%72%Impossible d'ouvrir le fichier %s en ecriture !%Impossible d'ouvrir le fichier %s en ecriture !
generic%73%Impossible d'ouvrir le fichier %s en lecture !%Impossible d'ouvrir le fichier %s en lecture !
generic%74%Impossible d'ouvrir le fichier %s en lecture et ecriture !%Impossible d'ouvrir le fichier %s en lecture et ecriture !
generic%75%Erreur generique Oracle : %s%Erreur generique Oracle : %s
generic%76%Erreur de syntaxe dans la requete SQL generee : %s%Erreur de syntaxe dans la requete SQL generee : %s
generic%77%Une valeur a inserer est trop large pour sa colonne !%Une valeur a inserer est trop large pour sa colonne !
generic%78%Impossible de se connecter a Oracle avec l'utilisateur %s%Impossible de se connecter a Oracle avec l'utilisateur %s
generic%79%Impossible de locker la table %s. Ressource deja occupee !%Impossible de locker la table %s. Ressource deja occupee !
generic%80%La requete interne SQL s'est terminee en erreur !%La requete interne SQL s'est terminee en erreur !
generic%81%Le nouveau separateur n'est pas specifie !%Le nouveau separateur n'est pas specifie !
generic%82%Le nombre maximal de colonnes %s du dictionnaire est depasse !%Le nombre maximal de colonnes %s du dictionnaire est depasse !
generic%83%La colonne %s apparait plusieurs fois dans le dictionnaire !%La colonne %s apparait plusieurs fois dans le dictionnaire !
generic%84%La source de donnees %s du dictionnaire est invalide !%La source de donnees %s du dictionnaire est invalide !
generic%85%La table %s ne peut-etre verouillee ou deverouillee !%La table %s ne peut-etre verouillee ou deverouillee !
generic%86%Vous ne pouvez pas remplacer une cle !%Vous ne pouvez pas remplacer une cle !
generic%87%Impossible de creer un nouveau processus %s !%Impossible de creer un nouveau processus %s !
generic%88%Le nombre maximal de tables %s est depasse%Le nombre maximal de tables %s est depasse
generic%89%Option ou suffixe de recherche invalide !%Option ou suffixe de recherche invalide !
generic%90%Pas de librairie chargee pour acceder a la base de donnees !%Pas de librairie chargee pour acceder a la base de donnees !
generic%91%Variable d'environnement %s manquante ou non exportee !%Variable d'environnement %s manquante ou non exportee !
generic%92%Parametre <+ recent que> inferieur au parametre <+ vieux que>.%Parametre <+ recent que> inferieur au parametre <+ vieux que>.
generic%93%Le type de la colonne %s est invalide !%Le type de la colonne %s est invalide !
generic%94%Impossible de retrouver le formulaire %s%Impossible de retrouver le formulaire %s
generic%95%Impossible de retrouver le panneau de commandes %s.%Impossible de retrouver le panneau de commandes %s.
generic%96%L'operateur de selection est incorrect !%L'operateur de selection est incorrect !
generic%97%Aucune valeur donnee%Aucune valeur donnee
generic%98%La taille maximale %s d'une ligne est depassee !%La taille maximale %s d'une ligne est depassee !
generic%99%Le champ %s est mal decrit dans la table %s%Le champ %s est mal decrit dans la table %s
generic%100%%s%%s
generic%101%Le parametre %s n'est pas un chiffre%Le parametre %s n'est pas un chiffre
generic%102%L'utilisateur %s n'existe pas%L'utilisateur %s n'existe pas
generic%103%La cle de reference de la contrainte sur %s est incorrecte.%La cle de reference de la contrainte sur %s est incorrecte.
generic%104%Erreur lors du delete sur %s%Erreur lors du delete sur %s
generic%105%La variable %s n'est pas du bon type%La variable %s n'est pas du bon type
generic%106%Probleme lors du chargement de l'environnement %s%Probleme lors du chargement de l'environnement %s
generic%107%Environnement %s non accessible%Environnement %s non accessible
generic%108%Probleme pour acceder a la table %s%Probleme pour acceder a la table %s
generic%109%La table %s n'existe pas ou n'est pas accessible%La table %s n'existe pas ou n'est pas accessible
generic%110%Impossible de retrouver l'objet %s%Impossible de retrouver l'objet %s
generic%111%La table %s existe sous plusieurs schemas%La table %s existe sous plusieurs schemas
generic%112%Probleme pour recuperer les contraintes de %s%Probleme pour recuperer les contraintes de %s
generic%113%Erreur lors du disable de contraintes de %s%Erreur lors du disable de contraintes de %s
generic%114%Erreur lors de l'enable de contraintes de %s%Erreur lors de l'enable de contraintes de %s
generic%115%Erreur lors du chargement de la table %s%Erreur lors du chargement de la table %s
generic%116%Des enregistrements ont ete rejetes pour la table %s%Des enregistrements ont ete rejetes pour la table %s
generic%117%La contrainte %s est invalide !%La contrainte %s est invalide !
generic%118%Le nombre maximal %s de cles etrangeres est depasse.%Le nombre maximal %s de cles etrangeres est depasse.
generic%119%Le nombre maximal %s de contraintes est depasse.%Le nombre maximal %s de contraintes est depasse.
generic%120%Impossible de creer le fichier %s%Impossible de creer le fichier %s
generic%121%La table %s n'est pas une table de reference.%La table %s n'est pas une table de reference.
generic%122%La table %s existe sous plusieurs cles etrang�res.%La table %s existe sous plusieurs cles etrang�res.
generic%123%Les droits sur le fichier %s sont incorrects.%Les droits sur le fichier %s sont incorrects.
generic%124%Probleme pour recuperer les informations '%s' de la Machine %s.%Probleme pour recuperer les informations '%s' de la Machine %s.
generic%125%Le type de la licence est invalide.%Le type de la licence est invalide.
generic%126%L'utilisateur %s n'est pas administrateur du systeme.%L'utilisateur %s n'est pas administrateur du systeme.
generic%127%Les colonnes %s doivent absolument contenir une valeur.%Les colonnes %s doivent absolument contenir une valeur.
generic%128%La table %s ne possede pas de cle primaire.%La table %s ne possede pas de cle primaire.
generic%129%La valeur d'une cle primaire ne peut-etre nulle.%La valeur d'une cle primaire ne peut-etre nulle.
generic%130%Options de commande %s incompatibles%Options de commande %s incompatibles
generic%131%Le tri de s�l�ction '%s' est invalide.%Le tri de s�l�ction '%s' est invalide.
generic%132%Le format de la date '%s' est invalide.%Le format de la date '%s' est invalide.
generic%133%Les el�ments % de la date doivent �tre s�par�s par un caract�re.%Les el�ments % de la date doivent �tre s�par�s par un caract�re.
generic%134%La date '%s' ne correspond pas au format %s.%La date '%s' ne correspond pas au format %s.
generic%148%Vous n'avez pas les droits %s.%Vous n'avez pas les droits %s.
generic%149%Probleme d'environnement %s%Probleme d'environnement %s
generic%150%Mot de Passe inconnu pour le user %s sur la base $ORACLE_SID%Mot de Passe inconnu pour le user %s sur la base $ORACLE_SID
generic%151%Variables inconnues BV_ORAUSER et/ou BV_ORAPASS%Variables inconnues BV_ORAUSER et/ou BV_ORAPASS
generic%152%L'intance %s est invalide ou non demarr�e.%L'intance %s est invalide ou non demarr�e.
V1_alim_30_motcle%0001%ECHEC ce l'Insert Arg de %s dans t_me_alma%ECHEC ce l'Insert Arg de %s dans t_me_alma
V1_alim_30_motcle%0002%Argument de la methode %s non declare dans me_alma%Argument de la methode %s non declare dans me_alma
V1_alim_30_motcle%0003%Rang de l'argument de la methode %s incoherent%Rang de l'argument de la methode %s incoherent
V1_alim_30_motcle%0004%ECHEC de l'insertion du mot cle %s dans t_me_ma%ECHEC de l'insertion du mot cle %s dans t_me_ma
V1_alim_40_meth%0001%Le mot cle d'action %s n'existe pas%Le mot cle d'action %s n'existe pas
V1_alim_40_meth%0002%L'Insertion de la methode physique %s a echoue%L'Insertion de la methode physique %s a echoue
V1_alim_40_meth%0003%L'Insertion de la variable interne %s a echoue%L'Insertion de la variable interne %s a echoue
V1_alim_40_meth%0004%L'Insertion du type physique %s a echoue%L'Insertion du type physique %s a echoue
PC_CHGSTAT_SERV%0004%Aucune instance n'est associee a l'application %s%Aucune instance n'est associee a l'application %s
generic%301%Le module applicatif %s n'est pas ou mal declar�.%Le module applicatif %s n'est pas ou mal declar�.
generic%302%L'instance de service %s ne semble pas exister.%L'instance de service %s ne semble pas exister.
generic%303%Le script fils <%s> a retourne un warning%Le script fils <%s> a retourne un warning
generic%304%Le script fils <%s> a retourne une erreur bloquante%Le script fils <%s> a retourne une erreur bloquante
generic%305%Le script fils <%s> a retourne une erreur fatale%Le script fils <%s> a retourne une erreur fatale
generic%306%Le script fils <%s> a retourne un code d'erreur errone %s%Le script fils <%s> a retourne un code d'erreur errone %s
generic%308%Erreur a l'execution de %s%Erreur a l'execution de %s
generic%309%Le service %s '%s' n'existe pas.%Le service %s '%s' n'existe pas.
generic%310%Le service %s '%s' est deja demarre.%Le service %s '%s' est deja demarre.
generic%311%Le service %s '%s' est deja arrete.%Le service %s '%s' est deja arrete.
generic%312%Le service %s '%s' n'a pas demarre correctement.%Le service %s '%s' n'a pas demarre correctement.
generic%313%Le service %s '%s' ne s'est pas arrete correctement.%Le service %s '%s' ne s'est pas arrete correctement.
generic%314%Le service %s '%s' n'est pas ou mal declar�.%Le service %s '%s' n'est pas ou mal declar�.
generic%315%Le module applicatif %s ne poss�de aucune instance de service.%Le module applicatif %s ne poss�de aucune instance de service.
generic%316%La ressource %s '%s' n'est pas ou mal declar�.%La ressource %s '%s' n'est pas ou mal declar�.
generic%317%Impossible de choisir un type pour le Service %s '%s'.%Impossible de choisir un type pour le Service %s '%s'.
generic%318%Impossible de choisir un type de service pour le I-CLES %s.%Impossible de choisir un type de service pour le I-CLES %s.
generic%319%La table %s n'est pas collectable.%La table %s n'est pas collectable.
generic%320%Le type de ressource %s n'est pas ou mal d�clar�.%Le type de ressource %s n'est pas ou mal d�clar�.
generic%321%Le Type de Service %s du I-CLES %s n'existe pas.%Le Type de Service %s du I-CLES %s n'existe pas.
generic%401%Le repertoire %s n'existe pas%Le repertoire %s n'existe pas
generic%402%Impossible de creer le repertoire %s%Impossible de creer le repertoire %s
generic%403%Impossible d'ecrire dans le repertoire %s%Impossible d'ecrire dans le repertoire %s
generic%404%Impossible de lire le contenu du repertoire %s%Impossible de lire le contenu du repertoire %s
generic%405%Le fichier %s n'existe pas ou est vide%Le fichier %s n'existe pas ou est vide
generic%406%Le fichier %s existe deja%Le fichier %s existe deja
generic%408%Le fichier %s n'est pas au format %s%Le fichier %s n'est pas au format %s
generic%409%Erreur lors de l'initialisation du fichier %s%Erreur lors de l'initialisation du fichier %s
generic%410%Probleme lors de la restauration/decompression de %s%Probleme lors de la restauration/decompression de %s
generic%411%Probleme lors de la decompression de %s%Probleme lors de la decompression de %s
generic%412%Probleme lors de la compression de %s%Probleme lors de la compression de %s
generic%413%Probleme lors de la securisation/compression de %s%Probleme lors de la securisation/compression de %s
generic%414%Le Lecteur %s doit etre NO REWIND pour avancer/reculer%Le Lecteur %s doit etre NO REWIND pour avancer/reculer
generic%415%Le device %s n'existe pas ou est indisponible%Le device %s n'existe pas ou est indisponible
generic%416%Probleme lors de la creation du lien vers %s%Probleme lors de la creation du lien vers %s
generic%417%Le lecteur %s est inaccessible%Le lecteur %s est inaccessible
generic%420%Impossible d'aller sous le r�pertoire '%s'.%Impossible d'aller sous le r�pertoire '%s'.
ME_CREATE_SYNORA%0001%Probleme a la creation du Synonyme %s%Probleme a la creation du Synonyme %s
ME_DROP_SYNORA%0001%Probleme a la suppression du Synonyme %s%Probleme a la suppression du Synonyme %s
ME_LOAD_TABORA%0001%Echec du Load sqlldr de %s%Echec du Load sqlldr de %s
ME_RESTORE_TABORA%0001%Erreur lors de la restauration de la table %s%Erreur lors de la restauration de la table %s
ME_SECURE_TABORA%0001%Impossible de recuperer la taille du tablespace %s%Impossible de recuperer la taille du tablespace %s
ME_SECURE_TABORA%0002%Impossible de recuperer la taille de la table %s%Impossible de recuperer la taille de la table %s
ME_SECURE_TABORA%0003%Erreur lors de la securisation de la table %s%Erreur lors de la securisation de la table %s
ME_SECURE_TABORA%0004%Impossible de recuperer la taille de la sauvegarde%Impossible de recuperer la taille de la sauvegarde
ME_SECURE_TABORA%0365%Probleme lors de la mise a jour de la table %s%Probleme lors de la mise a jour de la table %s
ME_TRUNC_TABORA%176%Probleme de truncate sur %s (Contrainte type P referencee) %Probleme de truncate sur %s (Contrainte type P referencee) 
PC_BACK_TBSORA%137%Probleme pour mettre le TBSPACE %s en BEGIN BACKUP%Probleme pour mettre le TBSPACE %s en BEGIN BACKUP
PC_BACK_TBSORA%138%Probleme pour mettre le TBSPACE %s en END BACKUP%Probleme pour mettre le TBSPACE %s en END BACKUP
PC_BACK_TBSORA%139%Probleme pour manipuler le TBSPACE %s%Probleme pour manipuler le TBSPACE %s
PC_LISTBACK_ARCHORA%0001%Il manque la sequence d'archives %s pour la base %s%Il manque la sequence d'archives %s pour la base %s
PC_LISTBACK_ARCHORA%0002%Il n'existe pas d'archives commen�ant a la sequence %s.%Il n'existe pas d'archives commen�ant a la sequence %s.
PC_LISTBACK_CTRLORA%128%Impossible d'interroger les logfiles de %s%Impossible d'interroger les logfiles de %s
PC_LISTBACK_CTRLORA%132%Impossible d'interroger les controlfiles de %s%Impossible d'interroger les controlfiles de %s
PC_LISTID_INSORA%182%Impossible de trouver la Base du user %s%Impossible de trouver la Base du user %s
PC_SWITCH_LOGORA%127%Probleme lors du switch des logfiles de %s%Probleme lors du switch des logfiles de %s
PC_SWITCH_LOGORA%128%Impossible d'interroger les logfiles pour %s%Impossible d'interroger les logfiles pour %s
generic%501%L'instance Oracle %s n'est pas demarree%L'instance Oracle %s n'est pas demarree
generic%502%L'instance Oracle %s n'est pas arretee%L'instance Oracle %s n'est pas arretee
generic%503%%s n'est pas un mode d'arret Oracle valide%%s n'est pas un mode d'arret Oracle valide
generic%504%%s n'est pas un mode de demarrage Oracle valide%%s n'est pas un mode de demarrage Oracle valide
generic%505%La base Oracle %s existe deja dans /etc/oratab%La base Oracle %s existe deja dans /etc/oratab
generic%506%Impossible de retrouver l'environnement de l'instance Oracle %s%Impossible de retrouver l'environnement de l'instance Oracle %s
generic%507%Impossible de retrouver l'init file de la base %s%Impossible de retrouver l'init file de la base %s
generic%508%Le fichier de config de %s n'est pas renseigne dans l'initfile%Le fichier de config de %s n'est pas renseigne dans l'initfile
generic%509%Les controlfiles de %s ne sont pas renseignes dans les initfiles%Les controlfiles de %s ne sont pas renseignes dans les initfiles
generic%510%Les parametres d'archive %s n'existent pas dans les initfiles%Les parametres d'archive %s n'existent pas dans les initfiles
generic%511%Parametre log_archive_dest de %s non defini dans les initfiles%Parametre log_archive_dest de %s non defini dans les initfiles
generic%512%Parametre log_archive_format de %s non defini dans les initfiles%Parametre log_archive_format de %s non defini dans les initfiles
generic%513%L'archivage de %s n'est pas demarre correctement%L'archivage de %s n'est pas demarre correctement
generic%514%L'archivage de %s n'est pas arrete correctement%L'archivage de %s n'est pas arrete correctement
generic%515%Script SQL %s non accessible%Script SQL %s non accessible
generic%517%Le script SQL %s ne s'est pas execute correctement%Le script SQL %s ne s'est pas execute correctement
generic%518%Probleme lors de la suppression de la table %s %Probleme lors de la suppression de la table %s 
generic%519%Probleme a l'execution du delete ou truncate de %s sur $ORACLE_SID%Probleme a l'execution du delete ou truncate de %s sur $ORACLE_SID
generic%520%Aucun Archive Oracle pour la Base %s%Aucun Archive Oracle pour la Base %s
PC_INITF_SQLNET%004%La configuration SqlNet %s de %s est introuvable%La configuration SqlNet %s de %s est introuvable
FT_LISTLST_SQLNET%346%Aucun Listener convenablement declare dans %s%Aucun Listener convenablement declare dans %s
FT_LIST_TNSNAME%346%Aucun Service TNS convenablement declare dans %s%Aucun Service TNS convenablement declare dans %s
PC_ENV_SQLNET%506%Impossible de trouver l'environnement de l'instance Sqlnet %s%Impossible de trouver l'environnement de l'instance Sqlnet %s
PC_LISTID_SQLNET%182%Impossible de trouver le Noyau SqlNet du user %s%Impossible de trouver le Noyau SqlNet du user %s
PC_STAT_TNSNAME%001%Le service TNS %s n'est pas decrit%Le service TNS %s n'est pas decrit
PC_STAT_TNSNAME%002%Il n'y a pas de listener demarre servant le service TNS %s%Il n'y a pas de listener demarre servant le service TNS %s
PC_STAT_TNSNAME%003%Erreur de configuration de l'adresse du service TNS %s%Erreur de configuration de l'adresse du service TNS %s

EXPECTED_OUTPUT
chomp $expected_string;
$expected_error = << 'EXPECTED_ERRSTD';

EXPECTED_ERRSTD
chomp $expected_error;
SKIP: {
skip q{Bug I-TOOLS 2.0}, 3;


run3('Select -s from error_messages | Formate_File -s\\;/% -n 4 -', undef, \$return_string, \$return_error);

$home=quotemeta($ENV{TOOLS_HOME});
$return_string =~ s/$home/TOOLS_HOME/g;
$return_error =~ s/$home/TOOLS_HOME/g;

if ( $? == -1 ) {
	BAIL_OUT("<".'Select -s from error_messages | Formate_File -s\\;/% -n 4 -'."> retourne -1");
}
$return_code = $? >> 8;

is ( $return_code ,$expected_code , "<".'Select -s from error_messages | Formate_File -s\\;/% -n 4 -'."> return code $expected_code");
is ( $return_string ,$expected_string , "<".'Select -s from error_messages | Formate_File -s\\;/% -n 4 -'."> output <".q{TEST%1%tes...}.">");

# test si a renvoyer une erreur ou non
is ( $return_error ne '', $expected_error ne '', "<".'Select -s from error_messages | Formate_File -s\\;/% -n 4 -'."> errstd") or diag($return_error);

}


##################
# Select -s from error_messages | Formate_File -s\;/% -n 5 -
##################

$expected_code = 0;
$expected_string = <<'EXPECTED_OUTPUT';
TEST%1%test sans quote%%test sans quote
TEST%2%test avec ' des ' quote%%test avec ' des ' quote
TEST%3%test avec " des " double quote%%test avec " des " double quote
TEST%4%test avec \" des \' quote echappees%%test avec \" des \' quote echappees
TEST%5%test avec \\ echappements \n%%test avec \\ echappements \n
TEST%6%test avec trop de % separ%ateurs;
TEST%7%test avec des $variables $TESTVAR%%test avec des $variables $TESTVAR
TEST%8%test avec des $variables $(echo "commande evaluee")%%test avec des $variables $(echo "commande evaluee")
TEST%9%test avec des $variables `echo "commande evaluee"`%%test avec des $variables `echo "commande evaluee"`
TEST_${TESTVAR}%0%test avec des une clef contenant une variable%%test avec des une clef contenant une variable
Check%65%Non unicite de la clef%%Non unicite de la clef
Insert%8%La condition de selection de cle n'est pas valide%%La condition de selection de cle n'est pas valide
Insert%97%Aucune valeur a inserer n'est specifiee%%Aucune valeur a inserer n'est specifiee
Modify%8%La condition de selection de la cle n est pas valide%%La condition de selection de la cle n est pas valide
Modify%68%Aucune ligne trouvee a modifier%%Aucune ligne trouvee a modifier
Modify%97%Aucune valeur a modifier n'est specifiee%%Aucune valeur a modifier n'est specifiee
Remove%68%Aucune ligne trouvee a supprimer%%Aucune ligne trouvee a supprimer
Replace%8%La condition de selection de la cle n'est pas valide%%La condition de selection de la cle n'est pas valide
Replace%68%Aucune ligne trouvee a remplacer%%Aucune ligne trouvee a remplacer
Replace%97%Aucune valeur a remplacer n'est specifiee%%Aucune valeur a remplacer n'est specifiee
generic%1%Impossible de trouver l'executable %s%%Impossible de trouver l'executable %s
generic%2%Impossible de trouver la table %s%%Impossible de trouver la table %s
generic%3%Impossible de trouver ou d'ouvrir le fichier de definition %s%%Impossible de trouver ou d'ouvrir le fichier de definition %s
generic%4%Impossible de trouver le fichier %s%%Impossible de trouver le fichier %s
generic%5%Le fichier de definition %s n'est pas valide%%Le fichier de definition %s n'est pas valide
generic%6%La table %s est une table virtuelle%%La table %s est une table virtuelle
generic%7%La colonne %s n'existe pas%%La colonne %s n'existe pas
generic%8%La condition de selection n'est pas valide%%La condition de selection n'est pas valide
generic%9%La chaine de definition %s n'est pas valide ou est absente%%La chaine de definition %s n'est pas valide ou est absente
generic%10%Impossible d'ouvrir le fichier %s%%Impossible d'ouvrir le fichier %s
generic%11%Impossible d'ecrire dans le fichier %s%%Impossible d'ecrire dans le fichier %s
generic%12%Impossible de supprimer le fichier %s%%Impossible de supprimer le fichier %s
generic%13%Impossible de changer les droits sur le fichier %s%%Impossible de changer les droits sur le fichier %s
generic%14%Impossible de renommer/deplacer le fichier %s en %s%%Impossible de renommer/deplacer le fichier %s en %s
generic%15%Impossible de copier le fichier %s%%Impossible de copier le fichier %s
generic%16%Erreur lors d'une ecriture dans le fichier %s%%Erreur lors d'une ecriture dans le fichier %s
generic%17%La commande <%s> a echoue%%La commande <%s> a echoue
generic%18%La variable racine BV_HOME ou TOOLS_HOME n'est pas exportee !%%La variable racine BV_HOME ou TOOLS_HOME n'est pas exportee !
generic%19%L'evaluation de <%s> est incorrecte !%%L'evaluation de <%s> est incorrecte !
generic%20%L'option %s n'est pas valide%%L'option %s n'est pas valide
generic%21%Le nombre d'arguments est incorrect%%Le nombre d'arguments est incorrect
generic%22%L'argument %s n'est pas valide%%L'argument %s n'est pas valide
generic%23%Utilisation incorrecte de l'option -h%%Utilisation incorrecte de l'option -h
generic%24%Ligne de commande incorrecte%%Ligne de commande incorrecte
generic%25%Erreur lors d'une allocation de memoire %s%%Erreur lors d'une allocation de memoire %s
generic%26%Erreur lors d'une re-allocation de memoire %s%%Erreur lors d'une re-allocation de memoire %s
generic%27%Erreur lors du chargement de la librairie %s !%%Erreur lors du chargement de la librairie %s !
generic%28%Impossible de retrouver le symbole %s en librairie !%%Impossible de retrouver le symbole %s en librairie !
generic%29%Erreur lors de la fermeture de la librairie %s !%%Erreur lors de la fermeture de la librairie %s !
generic%30%Votre licence d'utilisation %s a expire !%%Votre licence d'utilisation %s a expire !
generic%31%Le Hostid de la machine n'est pas valide !%%Le Hostid de la machine n'est pas valide !
generic%32%La licence n'est pas valide !%%La licence n'est pas valide !
generic%33%Il n'y a pas de licence valide pour ce produit !%%Il n'y a pas de licence valide pour ce produit !
generic%34%Le nombre de clients pour ce produit est depasse !%%Le nombre de clients pour ce produit est depasse !
generic%35%Le nom de fichier %s n'est pas valide%%Le nom de fichier %s n'est pas valide
generic%36%Le fichier %s est verouille%%Le fichier %s est verouille
generic%37%Impossible de poser un verrou sur le fichier %s%%Impossible de poser un verrou sur le fichier %s
generic%38%Le delai maximum d'attente de deverouillage a ete atteint%%Le delai maximum d'attente de deverouillage a ete atteint
generic%39%Le fichier %s n'est pas verouille%%Le fichier %s n'est pas verouille
generic%40%Impossible de retirer le verrou du fichier %s%%Impossible de retirer le verrou du fichier %s
generic%41%Le nombre maximal de selections simultanees est depasse%%Le nombre maximal de selections simultanees est depasse
generic%42%Le Handle d'une requete n'est pas valide%%Le Handle d'une requete n'est pas valide
generic%43%Le nombre maximal de conditions est depasse%%Le nombre maximal de conditions est depasse
generic%44%Impossible de retrouver la librairie %s !%%Impossible de retrouver la librairie %s !
generic%45%Un Handle n'est pas valide%%Un Handle n'est pas valide
generic%46%Le nombre maximal de fichiers ouverts est depasse%%Le nombre maximal de fichiers ouverts est depasse
generic%47%Le nombre maximal %s d'allocations de memoire est depasse%%Le nombre maximal %s d'allocations de memoire est depasse
generic%48%Impossible de retrouver le fichier de menu %s%%Impossible de retrouver le fichier de menu %s
generic%49%Impossible de retrouver le dictionnaire graphique %s%%Impossible de retrouver le dictionnaire graphique %s
generic%50%Erreur lors de l'execution de la fonction de log%%Erreur lors de l'execution de la fonction de log
generic%51%Erreur de type '%s' lors de la deconnexion Oracle !%%Erreur de type '%s' lors de la deconnexion Oracle !
generic%52%Impossible d'ecrire dans le fichier log %s%%Impossible d'ecrire dans le fichier log %s
generic%53%Impossible de determiner le nom du traitement%%Impossible de determiner le nom du traitement
generic%54%Le numero d'erreur est manquant%%Le numero d'erreur est manquant
generic%55%Le message d'information est manquant%%Le message d'information est manquant
generic%56%Le numero d'erreur %s n'a pas de message associe%%Le numero d'erreur %s n'a pas de message associe
generic%57%Le numero d'erreur %s n'est pas correct%%Le numero d'erreur %s n'est pas correct
generic%58%Le type de message de log n'est pas correct%%Le type de message de log n'est pas correct
generic%59%Le nom de table %s n'est pas valide%%Le nom de table %s n'est pas valide
generic%60%La colonne %s doit absolument contenir une valeur%%La colonne %s doit absolument contenir une valeur
generic%61%Il n'y a pas assez de valeurs par rapport au nombre de colonnes%%Il n'y a pas assez de valeurs par rapport au nombre de colonnes
generic%62%Il y a trop de valeurs par rapport au nombre de colonnes%%Il y a trop de valeurs par rapport au nombre de colonnes
generic%63%La valeur donnee pour la colonne %s n'est pas correcte.%%La valeur donnee pour la colonne %s n'est pas correcte.
generic%64%Le nom de la table n'est pas specifie%%Le nom de la table n'est pas specifie
generic%65%Non unicite de la clef de la ligne a inserer%%Non unicite de la clef de la ligne a inserer
generic%66%Le groupe d'utilisateurs %s n'existe pas%%Le groupe d'utilisateurs %s n'existe pas
generic%67%Impossible de remplacer une ligne sur une table sans clef%%Impossible de remplacer une ligne sur une table sans clef
generic%68%Aucune ligne trouvee%%Aucune ligne trouvee
generic%69%Entete de definition invalide !%%Entete de definition invalide !
generic%70%Variables d'environnement SEP ou FORMAT absente !%%Variables d'environnement SEP ou FORMAT absente !
generic%71%Il n'y a pas de lignes en entree stdin !%%Il n'y a pas de lignes en entree stdin !
generic%72%Impossible d'ouvrir le fichier %s en ecriture !%%Impossible d'ouvrir le fichier %s en ecriture !
generic%73%Impossible d'ouvrir le fichier %s en lecture !%%Impossible d'ouvrir le fichier %s en lecture !
generic%74%Impossible d'ouvrir le fichier %s en lecture et ecriture !%%Impossible d'ouvrir le fichier %s en lecture et ecriture !
generic%75%Erreur generique Oracle : %s%%Erreur generique Oracle : %s
generic%76%Erreur de syntaxe dans la requete SQL generee : %s%%Erreur de syntaxe dans la requete SQL generee : %s
generic%77%Une valeur a inserer est trop large pour sa colonne !%%Une valeur a inserer est trop large pour sa colonne !
generic%78%Impossible de se connecter a Oracle avec l'utilisateur %s%%Impossible de se connecter a Oracle avec l'utilisateur %s
generic%79%Impossible de locker la table %s. Ressource deja occupee !%%Impossible de locker la table %s. Ressource deja occupee !
generic%80%La requete interne SQL s'est terminee en erreur !%%La requete interne SQL s'est terminee en erreur !
generic%81%Le nouveau separateur n'est pas specifie !%%Le nouveau separateur n'est pas specifie !
generic%82%Le nombre maximal de colonnes %s du dictionnaire est depasse !%%Le nombre maximal de colonnes %s du dictionnaire est depasse !
generic%83%La colonne %s apparait plusieurs fois dans le dictionnaire !%%La colonne %s apparait plusieurs fois dans le dictionnaire !
generic%84%La source de donnees %s du dictionnaire est invalide !%%La source de donnees %s du dictionnaire est invalide !
generic%85%La table %s ne peut-etre verouillee ou deverouillee !%%La table %s ne peut-etre verouillee ou deverouillee !
generic%86%Vous ne pouvez pas remplacer une cle !%%Vous ne pouvez pas remplacer une cle !
generic%87%Impossible de creer un nouveau processus %s !%%Impossible de creer un nouveau processus %s !
generic%88%Le nombre maximal de tables %s est depasse%%Le nombre maximal de tables %s est depasse
generic%89%Option ou suffixe de recherche invalide !%%Option ou suffixe de recherche invalide !
generic%90%Pas de librairie chargee pour acceder a la base de donnees !%%Pas de librairie chargee pour acceder a la base de donnees !
generic%91%Variable d'environnement %s manquante ou non exportee !%%Variable d'environnement %s manquante ou non exportee !
generic%92%Parametre <+ recent que> inferieur au parametre <+ vieux que>.%%Parametre <+ recent que> inferieur au parametre <+ vieux que>.
generic%93%Le type de la colonne %s est invalide !%%Le type de la colonne %s est invalide !
generic%94%Impossible de retrouver le formulaire %s%%Impossible de retrouver le formulaire %s
generic%95%Impossible de retrouver le panneau de commandes %s.%%Impossible de retrouver le panneau de commandes %s.
generic%96%L'operateur de selection est incorrect !%%L'operateur de selection est incorrect !
generic%97%Aucune valeur donnee%%Aucune valeur donnee
generic%98%La taille maximale %s d'une ligne est depassee !%%La taille maximale %s d'une ligne est depassee !
generic%99%Le champ %s est mal decrit dans la table %s%%Le champ %s est mal decrit dans la table %s
generic%100%%s%%%s
generic%101%Le parametre %s n'est pas un chiffre%%Le parametre %s n'est pas un chiffre
generic%102%L'utilisateur %s n'existe pas%%L'utilisateur %s n'existe pas
generic%103%La cle de reference de la contrainte sur %s est incorrecte.%%La cle de reference de la contrainte sur %s est incorrecte.
generic%104%Erreur lors du delete sur %s%%Erreur lors du delete sur %s
generic%105%La variable %s n'est pas du bon type%%La variable %s n'est pas du bon type
generic%106%Probleme lors du chargement de l'environnement %s%%Probleme lors du chargement de l'environnement %s
generic%107%Environnement %s non accessible%%Environnement %s non accessible
generic%108%Probleme pour acceder a la table %s%%Probleme pour acceder a la table %s
generic%109%La table %s n'existe pas ou n'est pas accessible%%La table %s n'existe pas ou n'est pas accessible
generic%110%Impossible de retrouver l'objet %s%%Impossible de retrouver l'objet %s
generic%111%La table %s existe sous plusieurs schemas%%La table %s existe sous plusieurs schemas
generic%112%Probleme pour recuperer les contraintes de %s%%Probleme pour recuperer les contraintes de %s
generic%113%Erreur lors du disable de contraintes de %s%%Erreur lors du disable de contraintes de %s
generic%114%Erreur lors de l'enable de contraintes de %s%%Erreur lors de l'enable de contraintes de %s
generic%115%Erreur lors du chargement de la table %s%%Erreur lors du chargement de la table %s
generic%116%Des enregistrements ont ete rejetes pour la table %s%%Des enregistrements ont ete rejetes pour la table %s
generic%117%La contrainte %s est invalide !%%La contrainte %s est invalide !
generic%118%Le nombre maximal %s de cles etrangeres est depasse.%%Le nombre maximal %s de cles etrangeres est depasse.
generic%119%Le nombre maximal %s de contraintes est depasse.%%Le nombre maximal %s de contraintes est depasse.
generic%120%Impossible de creer le fichier %s%%Impossible de creer le fichier %s
generic%121%La table %s n'est pas une table de reference.%%La table %s n'est pas une table de reference.
generic%122%La table %s existe sous plusieurs cles etrang�res.%%La table %s existe sous plusieurs cles etrang�res.
generic%123%Les droits sur le fichier %s sont incorrects.%%Les droits sur le fichier %s sont incorrects.
generic%124%Probleme pour recuperer les informations '%s' de la Machine %s.%%Probleme pour recuperer les informations '%s' de la Machine %s.
generic%125%Le type de la licence est invalide.%%Le type de la licence est invalide.
generic%126%L'utilisateur %s n'est pas administrateur du systeme.%%L'utilisateur %s n'est pas administrateur du systeme.
generic%127%Les colonnes %s doivent absolument contenir une valeur.%%Les colonnes %s doivent absolument contenir une valeur.
generic%128%La table %s ne possede pas de cle primaire.%%La table %s ne possede pas de cle primaire.
generic%129%La valeur d'une cle primaire ne peut-etre nulle.%%La valeur d'une cle primaire ne peut-etre nulle.
generic%130%Options de commande %s incompatibles%%Options de commande %s incompatibles
generic%131%Le tri de s�l�ction '%s' est invalide.%%Le tri de s�l�ction '%s' est invalide.
generic%132%Le format de la date '%s' est invalide.%%Le format de la date '%s' est invalide.
generic%133%Les el�ments % de la date doivent �tre s�par�s par un caract�re.%%Les el�ments % de la date doivent �tre s�par�s par un caract�re.
generic%134%La date '%s' ne correspond pas au format %s.%%La date '%s' ne correspond pas au format %s.
generic%148%Vous n'avez pas les droits %s.%%Vous n'avez pas les droits %s.
generic%149%Probleme d'environnement %s%%Probleme d'environnement %s
generic%150%Mot de Passe inconnu pour le user %s sur la base $ORACLE_SID%%Mot de Passe inconnu pour le user %s sur la base $ORACLE_SID
generic%151%Variables inconnues BV_ORAUSER et/ou BV_ORAPASS%%Variables inconnues BV_ORAUSER et/ou BV_ORAPASS
generic%152%L'intance %s est invalide ou non demarr�e.%%L'intance %s est invalide ou non demarr�e.
V1_alim_30_motcle%0001%ECHEC ce l'Insert Arg de %s dans t_me_alma%%ECHEC ce l'Insert Arg de %s dans t_me_alma
V1_alim_30_motcle%0002%Argument de la methode %s non declare dans me_alma%%Argument de la methode %s non declare dans me_alma
V1_alim_30_motcle%0003%Rang de l'argument de la methode %s incoherent%%Rang de l'argument de la methode %s incoherent
V1_alim_30_motcle%0004%ECHEC de l'insertion du mot cle %s dans t_me_ma%%ECHEC de l'insertion du mot cle %s dans t_me_ma
V1_alim_40_meth%0001%Le mot cle d'action %s n'existe pas%%Le mot cle d'action %s n'existe pas
V1_alim_40_meth%0002%L'Insertion de la methode physique %s a echoue%%L'Insertion de la methode physique %s a echoue
V1_alim_40_meth%0003%L'Insertion de la variable interne %s a echoue%%L'Insertion de la variable interne %s a echoue
V1_alim_40_meth%0004%L'Insertion du type physique %s a echoue%%L'Insertion du type physique %s a echoue
PC_CHGSTAT_SERV%0004%Aucune instance n'est associee a l'application %s%%Aucune instance n'est associee a l'application %s
generic%301%Le module applicatif %s n'est pas ou mal declar�.%%Le module applicatif %s n'est pas ou mal declar�.
generic%302%L'instance de service %s ne semble pas exister.%%L'instance de service %s ne semble pas exister.
generic%303%Le script fils <%s> a retourne un warning%%Le script fils <%s> a retourne un warning
generic%304%Le script fils <%s> a retourne une erreur bloquante%%Le script fils <%s> a retourne une erreur bloquante
generic%305%Le script fils <%s> a retourne une erreur fatale%%Le script fils <%s> a retourne une erreur fatale
generic%306%Le script fils <%s> a retourne un code d'erreur errone %s%%Le script fils <%s> a retourne un code d'erreur errone %s
generic%308%Erreur a l'execution de %s%%Erreur a l'execution de %s
generic%309%Le service %s '%s' n'existe pas.%%Le service %s '%s' n'existe pas.
generic%310%Le service %s '%s' est deja demarre.%%Le service %s '%s' est deja demarre.
generic%311%Le service %s '%s' est deja arrete.%%Le service %s '%s' est deja arrete.
generic%312%Le service %s '%s' n'a pas demarre correctement.%%Le service %s '%s' n'a pas demarre correctement.
generic%313%Le service %s '%s' ne s'est pas arrete correctement.%%Le service %s '%s' ne s'est pas arrete correctement.
generic%314%Le service %s '%s' n'est pas ou mal declar�.%%Le service %s '%s' n'est pas ou mal declar�.
generic%315%Le module applicatif %s ne poss�de aucune instance de service.%%Le module applicatif %s ne poss�de aucune instance de service.
generic%316%La ressource %s '%s' n'est pas ou mal declar�.%%La ressource %s '%s' n'est pas ou mal declar�.
generic%317%Impossible de choisir un type pour le Service %s '%s'.%%Impossible de choisir un type pour le Service %s '%s'.
generic%318%Impossible de choisir un type de service pour le I-CLES %s.%%Impossible de choisir un type de service pour le I-CLES %s.
generic%319%La table %s n'est pas collectable.%%La table %s n'est pas collectable.
generic%320%Le type de ressource %s n'est pas ou mal d�clar�.%%Le type de ressource %s n'est pas ou mal d�clar�.
generic%321%Le Type de Service %s du I-CLES %s n'existe pas.%%Le Type de Service %s du I-CLES %s n'existe pas.
generic%401%Le repertoire %s n'existe pas%%Le repertoire %s n'existe pas
generic%402%Impossible de creer le repertoire %s%%Impossible de creer le repertoire %s
generic%403%Impossible d'ecrire dans le repertoire %s%%Impossible d'ecrire dans le repertoire %s
generic%404%Impossible de lire le contenu du repertoire %s%%Impossible de lire le contenu du repertoire %s
generic%405%Le fichier %s n'existe pas ou est vide%%Le fichier %s n'existe pas ou est vide
generic%406%Le fichier %s existe deja%%Le fichier %s existe deja
generic%408%Le fichier %s n'est pas au format %s%%Le fichier %s n'est pas au format %s
generic%409%Erreur lors de l'initialisation du fichier %s%%Erreur lors de l'initialisation du fichier %s
generic%410%Probleme lors de la restauration/decompression de %s%%Probleme lors de la restauration/decompression de %s
generic%411%Probleme lors de la decompression de %s%%Probleme lors de la decompression de %s
generic%412%Probleme lors de la compression de %s%%Probleme lors de la compression de %s
generic%413%Probleme lors de la securisation/compression de %s%%Probleme lors de la securisation/compression de %s
generic%414%Le Lecteur %s doit etre NO REWIND pour avancer/reculer%%Le Lecteur %s doit etre NO REWIND pour avancer/reculer
generic%415%Le device %s n'existe pas ou est indisponible%%Le device %s n'existe pas ou est indisponible
generic%416%Probleme lors de la creation du lien vers %s%%Probleme lors de la creation du lien vers %s
generic%417%Le lecteur %s est inaccessible%%Le lecteur %s est inaccessible
generic%420%Impossible d'aller sous le r�pertoire '%s'.%%Impossible d'aller sous le r�pertoire '%s'.
ME_CREATE_SYNORA%0001%Probleme a la creation du Synonyme %s%%Probleme a la creation du Synonyme %s
ME_DROP_SYNORA%0001%Probleme a la suppression du Synonyme %s%%Probleme a la suppression du Synonyme %s
ME_LOAD_TABORA%0001%Echec du Load sqlldr de %s%%Echec du Load sqlldr de %s
ME_RESTORE_TABORA%0001%Erreur lors de la restauration de la table %s%%Erreur lors de la restauration de la table %s
ME_SECURE_TABORA%0001%Impossible de recuperer la taille du tablespace %s%%Impossible de recuperer la taille du tablespace %s
ME_SECURE_TABORA%0002%Impossible de recuperer la taille de la table %s%%Impossible de recuperer la taille de la table %s
ME_SECURE_TABORA%0003%Erreur lors de la securisation de la table %s%%Erreur lors de la securisation de la table %s
ME_SECURE_TABORA%0004%Impossible de recuperer la taille de la sauvegarde%%Impossible de recuperer la taille de la sauvegarde
ME_SECURE_TABORA%0365%Probleme lors de la mise a jour de la table %s%%Probleme lors de la mise a jour de la table %s
ME_TRUNC_TABORA%176%Probleme de truncate sur %s (Contrainte type P referencee) %%Probleme de truncate sur %s (Contrainte type P referencee) 
PC_BACK_TBSORA%137%Probleme pour mettre le TBSPACE %s en BEGIN BACKUP%%Probleme pour mettre le TBSPACE %s en BEGIN BACKUP
PC_BACK_TBSORA%138%Probleme pour mettre le TBSPACE %s en END BACKUP%%Probleme pour mettre le TBSPACE %s en END BACKUP
PC_BACK_TBSORA%139%Probleme pour manipuler le TBSPACE %s%%Probleme pour manipuler le TBSPACE %s
PC_LISTBACK_ARCHORA%0001%Il manque la sequence d'archives %s pour la base %s%%Il manque la sequence d'archives %s pour la base %s
PC_LISTBACK_ARCHORA%0002%Il n'existe pas d'archives commen�ant a la sequence %s.%%Il n'existe pas d'archives commen�ant a la sequence %s.
PC_LISTBACK_CTRLORA%128%Impossible d'interroger les logfiles de %s%%Impossible d'interroger les logfiles de %s
PC_LISTBACK_CTRLORA%132%Impossible d'interroger les controlfiles de %s%%Impossible d'interroger les controlfiles de %s
PC_LISTID_INSORA%182%Impossible de trouver la Base du user %s%%Impossible de trouver la Base du user %s
PC_SWITCH_LOGORA%127%Probleme lors du switch des logfiles de %s%%Probleme lors du switch des logfiles de %s
PC_SWITCH_LOGORA%128%Impossible d'interroger les logfiles pour %s%%Impossible d'interroger les logfiles pour %s
generic%501%L'instance Oracle %s n'est pas demarree%%L'instance Oracle %s n'est pas demarree
generic%502%L'instance Oracle %s n'est pas arretee%%L'instance Oracle %s n'est pas arretee
generic%503%%s n'est pas un mode d'arret Oracle valide%%%s n'est pas un mode d'arret Oracle valide
generic%504%%s n'est pas un mode de demarrage Oracle valide%%%s n'est pas un mode de demarrage Oracle valide
generic%505%La base Oracle %s existe deja dans /etc/oratab%%La base Oracle %s existe deja dans /etc/oratab
generic%506%Impossible de retrouver l'environnement de l'instance Oracle %s%%Impossible de retrouver l'environnement de l'instance Oracle %s
generic%507%Impossible de retrouver l'init file de la base %s%%Impossible de retrouver l'init file de la base %s
generic%508%Le fichier de config de %s n'est pas renseigne dans l'initfile%%Le fichier de config de %s n'est pas renseigne dans l'initfile
generic%509%Les controlfiles de %s ne sont pas renseignes dans les initfiles%%Les controlfiles de %s ne sont pas renseignes dans les initfiles
generic%510%Les parametres d'archive %s n'existent pas dans les initfiles%%Les parametres d'archive %s n'existent pas dans les initfiles
generic%511%Parametre log_archive_dest de %s non defini dans les initfiles%%Parametre log_archive_dest de %s non defini dans les initfiles
generic%512%Parametre log_archive_format de %s non defini dans les initfiles%%Parametre log_archive_format de %s non defini dans les initfiles
generic%513%L'archivage de %s n'est pas demarre correctement%%L'archivage de %s n'est pas demarre correctement
generic%514%L'archivage de %s n'est pas arrete correctement%%L'archivage de %s n'est pas arrete correctement
generic%515%Script SQL %s non accessible%%Script SQL %s non accessible
generic%517%Le script SQL %s ne s'est pas execute correctement%%Le script SQL %s ne s'est pas execute correctement
generic%518%Probleme lors de la suppression de la table %s %%Probleme lors de la suppression de la table %s 
generic%519%Probleme a l'execution du delete ou truncate de %s sur $ORACLE_SID%%Probleme a l'execution du delete ou truncate de %s sur $ORACLE_SID
generic%520%Aucun Archive Oracle pour la Base %s%%Aucun Archive Oracle pour la Base %s
PC_INITF_SQLNET%004%La configuration SqlNet %s de %s est introuvable%%La configuration SqlNet %s de %s est introuvable
FT_LISTLST_SQLNET%346%Aucun Listener convenablement declare dans %s%%Aucun Listener convenablement declare dans %s
FT_LIST_TNSNAME%346%Aucun Service TNS convenablement declare dans %s%%Aucun Service TNS convenablement declare dans %s
PC_ENV_SQLNET%506%Impossible de trouver l'environnement de l'instance Sqlnet %s%%Impossible de trouver l'environnement de l'instance Sqlnet %s
PC_LISTID_SQLNET%182%Impossible de trouver le Noyau SqlNet du user %s%%Impossible de trouver le Noyau SqlNet du user %s
PC_STAT_TNSNAME%001%Le service TNS %s n'est pas decrit%%Le service TNS %s n'est pas decrit
PC_STAT_TNSNAME%002%Il n'y a pas de listener demarre servant le service TNS %s%%Il n'y a pas de listener demarre servant le service TNS %s
PC_STAT_TNSNAME%003%Erreur de configuration de l'adresse du service TNS %s%%Erreur de configuration de l'adresse du service TNS %s

EXPECTED_OUTPUT
chomp $expected_string;
$expected_error = << 'EXPECTED_ERRSTD';

EXPECTED_ERRSTD
chomp $expected_error;
SKIP: {
skip q{Bug I-TOOLS 2.0}, 3;


run3('Select -s from error_messages | Formate_File -s\\;/% -n 5 -', undef, \$return_string, \$return_error);

$home=quotemeta($ENV{TOOLS_HOME});
$return_string =~ s/$home/TOOLS_HOME/g;
$return_error =~ s/$home/TOOLS_HOME/g;

if ( $? == -1 ) {
	BAIL_OUT("<".'Select -s from error_messages | Formate_File -s\\;/% -n 5 -'."> retourne -1");
}
$return_code = $? >> 8;

is ( $return_code ,$expected_code , "<".'Select -s from error_messages | Formate_File -s\\;/% -n 5 -'."> return code $expected_code");
is ( $return_string ,$expected_string , "<".'Select -s from error_messages | Formate_File -s\\;/% -n 5 -'."> output <".q{TEST%1%tes...}.">");

# test si a renvoyer une erreur ou non
is ( $return_error ne '', $expected_error ne '', "<".'Select -s from error_messages | Formate_File -s\\;/% -n 5 -'."> errstd") or diag($return_error);

}

