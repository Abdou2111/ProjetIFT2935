# Bibliothèque JPA

**Application Java Swing de gestion d'une bibliothèque**  
Basée sur JPA (Hibernate), PostgreSQL, et Maven.

## Description
Cette application Swing affiche des statistiques et rapports à partir des tables du schéma `bibliotheque` :

- **Situation des adhérents** : nombre total d’emprunts et retards (>14 jours)  
- **Répartition des emprunts par genre**  
- **Top 3 des livres les plus empruntés**  
- **Répartition des commandes par état**  
- **Emprunts par année d’inscription**  
- **Adhérents ayant exactement 3 commandes**  
- **Emprunts par genre et année d’inscription**

Les entités JPA sont définies sous `com.example` : `Adherant`, `Livre`, `Emprunt`, `Commande`.

## Prérequis
- Java 17 (JDK)  
- Maven 3.x  
- PostgreSQL 12+  
- Rôle PostgreSQL `abdel` (modifiable selon votre configuration)

## Installation
1. Cloner le projet :
   ```bash
   git clone <url_du_repo>
   cd bibliotheque-jpa
   ```
2. Importer le schéma et les données :
   ```bash
   psql -U abdel -d postgres -f bib.sql
   ```
3. Vérifier la création des tables du schéma `bibliotheque` : `adherant`, `livre`, `emprunt`, `commande`.

## Configuration JPA
Éditer `src/main/resources/META-INF/persistence.xml` :
```xml
<persistence-unit name="bibliothequePU" transaction-type="RESOURCE_LOCAL">
  <class>com.example.Adherant</class>
  <class>com.example.Emprunt</class>
  <class>com.example.Livre</class>
  <class>com.example.Commande</class>
  <properties>
    <property name="javax.persistence.jdbc.url" value="jdbc:postgresql://localhost:5432/postgres"/>
    <property name="javax.persistence.jdbc.user" value="abdel"/>
    <property name="javax.persistence.jdbc.password" value=""/>
    <property name="javax.persistence.jdbc.driver" value="org.postgresql.Driver"/>
    <property name="hibernate.dialect" value="org.hibernate.dialect.PostgreSQLDialect"/>
    <property name="hibernate.hbm2ddl.auto" value="validate"/>
    <property name="hibernate.show_sql" value="true"/>
  </properties>
</persistence-unit>
```

## Lancer l’application
### Via Maven
```bash
mvn clean compile exec:java
```
### Jar exécutable
```bash
mvn clean package
java -jar target/bibliotheque-jpa-1.0-SNAPSHOT.jar
```
L’interface Swing s’ouvre avec 7 boutons, chacun déclenchant une méthode de `DemoQueries`.

## Utilisation
| Bouton                                    | Méthode Java                                    |
|-------------------------------------------|-------------------------------------------------|
| Situation des adhérents                   | `DemoQueries.showAdherantSituation()`            |
| Répartition des emprunts par genre        | `DemoQueries.showGenreEmprunts()`                |
| Top 3 livres les plus empruntés           | `DemoQueries.showTopLivres()`                    |
| Répartition des commandes par état        | `DemoQueries.showCommandesParEtat()`             |
| Emprunts par année d’inscription          | `DemoQueries.showEmpruntsParAnneeInscription()`  |
| Adhérents avec 3 commandes                | `DemoQueries.showAdherantsAvec3Commandes()`      |
| Emprunts par genre & année d’inscription  | `DemoQueries.showEmpruntsParGenreEtAnneeInscription()` |

## Structure du projet
```
bibliotheque-jpa/
├─ src/
│  ├─ main/
│  │  ├─ java/com/example/
│  │  │   ├─ Adherant.java
│  │  │   ├─ Livre.java
│  │  │   ├─ Emprunt.java
│  │  │   ├─ Commande.java
│  │  │   ├─ DemoQueries.java
│  │  │   └─ MainApp.java
│  │  └─ resources/META-INF/
│  │        └─ persistence.xml
├─ bib.sql
└─ pom.xml
```

## Contribuer
1. Forker le dépôt  
2. Créer une branche `feature/*`  
3. Commit & push  
4. Ouvrir une pull request

## Licence
Ce projet est sous licence MIT.

