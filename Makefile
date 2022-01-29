MARKDOWN=$(shell find . -iname "*.md")
# Form all 'html' counterparts
HTML=$(MARKDOWN:.md=.html)

ifeq ("${development}","TRUE")
	STYLE="${HOME}/vimwiki/style.css"
else
	STYLE="/style.css"
endif

.PHONY = all tar clean
all: $(HTML)

%.html: %.md style.css
	# convert md links to html and then pandoc the whole file
	sed 's/\.md)/\.html)/g' $< | \
		pandoc -s --template=template._html --metadata title="$*" --css $(STYLE) --from markdown --to html -o $@

clean:
	rm $(HTML)
