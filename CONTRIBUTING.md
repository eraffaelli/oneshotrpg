# Contributing to the One Shot RPG site

Please note that this project is released with a [Contributor Code of Conduct](https://github.com/oneshotrpg/oneshotrpg/blob/gh-pages/CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

## Stance Spelling and Grammar

One Shot RPG's stance on spelling and grammar is that it shouldn't get in the way of meaning. When suggesting a change, please consider if it's an actual misspelling or a stylistic issue. "It's" and "Its" are two different things and need correcting; role playing, roleplaying, and role-playing are stylistic choices and may need correcting depending on the context.

## Contributing a Spelling or Grammar Change

If the above is taken into consideration, we love having spelling and grammar issues fixed for us. A good way to submit these changes are to edit the file directly through GitHub. After clicking the edit button, you can fix the issue, enter your commit message, and propose the change.

## Making More Advanced Changes

We recommend running the site locally to make more advanced changes. Fork the repository, clone it down, run the site in Hugo, make and commit your change, then open a pull request.

## Running the Site Locally

Follow the [Hugo installation instructions](https://gohugo.io/getting-started/installing/) to get Hugo running locally and accessible through the command line. I set up an alias so I can call Hugo with `hugo`.

`hugo server` will launch an auto-reloading server that can be visited in your browser.  
`hugo` will build the site's content  
`sh build.sh` will fully build the CSS and site's content  

## Making CSS Changes

`npm install` to install dependencies  
`npm run watch` to watch changes and compile the sass folder  
`npm run build` to compile without watching  
