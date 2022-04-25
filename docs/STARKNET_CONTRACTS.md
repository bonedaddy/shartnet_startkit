# Starknet Contracts

## Inheritance

Inheritance is not currently supported by the compiler [ref](https://youtu.be/O2zntD0muZs?t=2839):
  * Base contracts define core functions which have no external functions and no constructors
  * Front end contracts import internal functions from base contracts, wrapping them in external functions


## Account Abstractions

On Starknet transactions have no "from" address, and are sent to an entrypoint, which is an account smart contract that takes care of:

* Authenticating the user
* Replay protection
* Funds protection
