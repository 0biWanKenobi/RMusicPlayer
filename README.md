# RMusicPlayer
Control a NodeJS-backed web radio in your local network, from your smartphone. This project is comprised of

- A [NodeJS](https://nodejs.org) server with
	- a very basic REST Api
	- a web frontend
	- Socket.io for bi-directional communication
-  A smartphone app developed with [Flutter](https://flutter.dev), with
	- UDP discovery & handshake with the NodeJS server
	- [Riverpod](https://riverpod.dev/) for state management
	- A basic interface (only play/pause) working

## ⚠️Caution⚠️
This project is in its infancy, therefore you'll find some undesirable code practices, such as

-  No HTTPS
- Insecure UDP handshake 
- Non-functional interface (eg. next / prev buttons in the app UI)

## Collaboration 

I'm very open to pull requests and issues, especially improving the security side. Even though server and client only communicate on the local network, and share very little data over it, it is no reason to skimp from strenghtening the project's security.
