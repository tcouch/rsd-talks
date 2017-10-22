PANDOC=pandoc

ROOT="/rsd-talks"

PANDOCARGS=-t revealjs -s \
     --css=$(ROOT)/site-styles/rits17.css \
     --css=$(ROOT)/site-styles/reveal.css \
     --default-image-extension=png --highlight-style=zenburn --mathjax -V revealjs-url=http://lab.hakim.se/reveal-js \
	   -V transition=slide -V theme=solarized

default: _site

%-reveal.html: %.md Makefile
	$(PANDOC) $(PANDOCARGS) $< -o $@

%.png: %.py Makefile
	python $< $@

%.png: %.nto Makefile
	neato $< -T png -o $@

%.png: %.dot Makefile
	dot $< -T png -o $@

%.png: %.uml Makefile plantuml.jar
	java -Djava.awt.headless=true -jar plantuml.jar -p < $< > $@

indigo.zip: Makefile
	rm -f indigo.zip
	wget https://github.com/UCL-RITS/indigo-jekyll/archive/master.zip -O indigo.zip

indigo-jekyll-master: Makefile indigo.zip
	rm -rf indigo-jekyll-master
	unzip indigo.zip
	touch indigo-jekyll-master

indigo: indigo-jekyll-master Makefile
	cp -r indigo-jekyll-master/indigo/images .
	cp -r indigo-jekyll-master/indigo/js .
	cp -r indigo-jekyll-master/indigo/css .
	cp -r indigo-jekyll-master/indigo/_includes .
	cp -r indigo-jekyll-master/indigo/_layouts .
	cp -r indigo-jekyll-master/indigo/favicon* .
	touch indigo

_site: technical/fabric-reveal.html \
			 technical/continuous-reveal.html \
	     technical/carpentry-compressed-reveal.html rsd/zacrosEASC-reveal.html \
			 technical/paradigms-reveal.html \
			 technical/version_control-reveal.html rsd/generated/RSD_Venn.png rsd/generated/governance.png indigo \
			 technical/generated/centralised_solo.png \
			 technical/generated/centralised_team.png \
			 technical/generated/centralised_team_noconflict.png \
			 technical/generated/distributed_concepts.png \
			 technical/generated/distributed_shared_conflicted.png \
			 technical/generated/distributed_shared_noconflict.png \
			 technical/generated/distributed_solo.png \
			 technical/generated/distributed_solo_publishing.png \
			 technical/generated/branching.png \
			 technical/generated/centralised.png \
			 technical/generated/distributed_practice.png \
			 technical/generated/distributed_principle.png \
			 technical/generated/revisions.png \
			 rsd/dashboard_announce-reveal.html \
			 rsd/experiences-reveal.html \
			 rsd/training-reveal.html \
			 site-styles/reveal.css
	jekyll build

plantuml.jar:
	wget http://sourceforge.net/projects/plantuml/files/plantuml.jar/download -O plantuml.jar

clean:
	rm -f rsd/generated/*.png
	rm -f technical/generated/*.png
	rm -f rsd/*.html
	rm -f technical/*.html
	rm -f index.html
	rm -f plantuml.jar
	rm -rf _site
	rm -rf images js css _includes _layouts favicon* remaster.zip indigo-jekyll-remaster
