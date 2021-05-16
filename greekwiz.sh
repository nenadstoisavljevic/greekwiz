#!/bin/sh

# Visit this site for more about the Greek alphabet
# https://daedalus.umkc.edu/FirstGreekBook/JWW_FGB1.html

alphabet="Form;	Phonetic Value;		Name;
Α,α;	papa,father;		alpha;
Β,β;	bed;			beta;
Γ,γ;	go,sing;		gamma;
Δ,δ;	do;			delta;
Ε,ε;	met;			epsilon;
Ζ,ζ;	adze;			zeta;
Η,η;	prey;			eta;
Θ,θ;	thin;			theta;
Ι,ι;	pin,machine;		iota;
Κ,κ;	kill;			kappa;
Λ,λ;	land;			lambda;
Μ,μ;	men;			mu;
Ν,ν;	now;			nu;
Ξ,ξ;	wax;			xi;
Ο,ο;	obey;			omicron;
Π,π;	pet;			pi;
Ρ,ρ;	run;			rho;
Σ,σ,ς;	sit;			sigma;
Τ,τ;	tell;			tau;
Υ,υ;	French u, German ό;	upsilon;
Φ,φ;	graphic;		phi;
Χ,χ;	German buch;		chi;
Ψ,ψ;	hips;			psi;
Ω,ω;	tone;			omega;"

dipthongs="αι;	aisle;
αυ;	ou in hour;
ει;	eight;
υι;	quit;
οι;	oil;
ου;	group;
ευ;	ĕh-oo;
ηυ;	ĕh-oo"

all() { \
	for i in $(seq 1 24);
	do
		# Shuffle both lower and uppercase Greek letters.
        	letter=$(echo "$alphabet" | cut -d ';' -f 1 | sed '1d;s/,/\n/g' | shuf -n 1)
		name=$(echo "$alphabet" | grep "$letter" | cut -d ';' -f 3 | xargs)

		printf "Please give the name of %s: " "$letter" ; read -r guess
		user=$(echo "$guess" | tr '[:upper:]' '[:lower:]')
		[ "$user" =  "$name" ] && printf "You are correct.\n" || printf "Ughh, the correct name was %s.\n" "$name"
	done ;}

vowels() { \
	for i in $(seq 1 7);
	do
		# Shuffle the vowels of the Greek alphabet.
        	vowel=$(echo "α,ε,η,ι,ο,ω,υ" | sed 's/,/\n/g' | shuf -n 1)
		name=$(echo "$alphabet" | grep "$vowel" | cut -d ';' -f 3 | xargs)

		printf "Please give the name of %s: " "$vowel" ; read -r guess
		user=$(echo "$guess" | tr '[:upper:]' '[:lower:]')
		[ "$user" =  "$name" ] && printf "You are correct.\n" || printf "Ughh, the correct name was %s.\n" "$name"
	done ;}

dipthongs() { \
	for i in $(seq 1 8);
	do
        	dipthong=$(echo "$dipthongs" | cut -d ';' -f 1 | sed 's/,/\n/g' | shuf -n 1)
		pron=$(echo "$dipthongs" | grep "$dipthong" | cut -d ';' -f 2 | xargs)
		printf "%s is pronounced as %s\n" "$dipthong" "$pron"
	done ;}

list() { \
	echo "$alphabet" | sed 's/;/ /g' | less ;}

case "$1" in
	all) all ;;
	vowels) vowels ;;
	dipthongs ) dipthongs ;;
	ls ) list ;;
	*) cat << EOF
greekwiz: learn the ancient Greek alphabet straight from the
command line, including offline availability.

Options:
  all		Practice studying all the letters of the Greek alphabet (24)
  vowels	Learn only the vowels of the Greek alphabet (7)
  dipthongs	Practice prounouncing the dipthongs (8 with 3 improper)
  ls		Print a table of the form, phonetic value, and name
  all else	Print this message
EOF
esac