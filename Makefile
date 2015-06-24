PANDOC=pandoc

ROOT=""

PANDOCARGS=-t revealjs -s -V theme=night --css=http://lab.hakim.se/reveal-js/css/theme/night.css \
					 --css=$(ROOT)/css/ucl_reveal.css --css=$(ROOT)/site-styles/reveal.css \
           --default-image-extension=png --highlight-style=zenburn --mathjax -V revealjs-url=http://lab.hakim.se/reveal-js

default: _site

%-reveal.html: %.md Makefile
	$(PANDOC) $(PANDOCARGS) $< -o $@

%.png: %.py Makefile
	python $< $@

%.png: %.nto Makefile
	neato $< -T png -o $@

%.png: %.dot Makefile
	dot $< -T png -o $@

%.png: %.uml Makefile
	plantuml -p < $< > $@

remaster.zip: Makefile
	rm -f remaster.zip
	wget https://github.com/UCL-RITS/indigo-jekyll/archive/remaster.zip

indigo-jekyll-remaster: Makefile remaster.zip
	rm -rf indigo-jekyll-remaster
	unzip remaster.zip
	touch indigo-jekyll-remaster

indigo: indigo-jekyll-remaster Makefile
	cp -r indigo-jekyll-remaster/indigo/images .
	cp -r indigo-jekyll-remaster/indigo/js .
	cp -r indigo-jekyll-remaster/indigo/css .
	cp -r indigo-jekyll-remaster/indigo/_includes .
	cp -r indigo-jekyll-remaster/indigo/_layouts .
	cp -r indigo-jekyll-remaster/indigo/favicon* .
	touch indigo

_site: rsd/scholar-reveal.html technical/fabric-reveal.html \
	     technical/carpentry-compressed-reveal.html rsd/zacrosEASC-reveal.html \
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
			 technical/generated/revisions.png
	jekyll build	

clean:
	rm -f rsd/generated/*.png
	rm -f technical/generated/*.png
	rm -f rsd/*.html
	rm -f technical/*.html
	rm -f index.html
	rm -rf _site
	rm -rf images js css _includes _layouts favicon* remaster.zip indigo-jekyll-remaster

