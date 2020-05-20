# Car Camper

An elixir app I was working on for planing road / camping trips. Not finished and I haven't worked on it in a while. I may come back to it.

Built with docker

To Run:
 * docker-compose up
 * migrations: `docker-compose exec phoenix mix ecto.migrate` or `docker-compose exec phoenix mix ecto.setup`
 * install node assets: `docker-compose exec phoenix bash -c "cd assets && npm install"`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
