#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
 then
 echo "Please provide an element as an argument."
 exit
fi 
if [[ $1 =~ ^[0-9]+$ ]]
 then
 CHOSEN_ELEMENT=$($PSQL "SELECT name FROM elements WHERE atomic_number = $1")
else   
 CHOSEN_ELEMENT=$($PSQL "SELECT name FROM elements WHERE symbol = '$1' OR name = '$1'")
fi 
if [[ -z $CHOSEN_ELEMENT ]]
  then
  echo "I could not find that element in the database."
  exit
fi 
ELEMENT_NUMBER=$($PSQL "SELECT atomic_number FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE name = '$CHOSEN_ELEMENT'")
ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE name = '$CHOSEN_ELEMENT'")
ELEMENT_MASS=$($PSQL "SELECT atomic_mass FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE name = '$CHOSEN_ELEMENT'")
ELEMENT_MELT=$($PSQL "SELECT melting_point_celsius FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE name = '$CHOSEN_ELEMENT'")
ELEMENT_BOIL=$($PSQL "SELECT boiling_point_celsius FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE name = '$CHOSEN_ELEMENT'")
ELEMENT_TYPE=$($PSQL "SELECT type FROM elements LEFT JOIN properties USING (atomic_number) LEFT JOIN types USING (type_id) WHERE name = '$CHOSEN_ELEMENT'")

echo "The element with atomic number "$ELEMENT_NUMBER" is "$CHOSEN_ELEMENT" ("$ELEMENT_SYMBOL"). It's a "$ELEMENT_TYPE", with a mass of "$ELEMENT_MASS" amu. "$CHOSEN_ELEMENT" has a melting point of "$ELEMENT_MELT" celsius and a boiling point of "$ELEMENT_BOIL" celsius."


