# shartnet_startkit

# installation

to prepare your environment for StarkNet development, Cairo and Python3.7 need to be installed. To do so a preparation script is provided, which is supported on Ubuntu systems, and likely with small modifications on mac osx systems.

There are two installation options, one which installs the visual studio code cairo extension, and one which does not. The default behavior is to install this extension.

```shell
$> ./scripts/prepare.sh # installs visual studio code extension
$> ./scripts/prepare.sh yes # installs visual studio code extension
$> ./scripts/prepare.sh no # does not install visual studio code extension
$> ./scripts/prepare.sh shart # does not install visual studio code extension
```

Then you will need to launch a new terminal window to read the newly set environment variables, and run the following command:

```shell
$> starknet deploy_account
Sent deploy account contract transaction.

NOTE: This is a modified version of the OpenZeppelin account contract. The signature is computed
differently.

Contract address: 0x07d733ba0cdde2c46e2840648f379b97efc767084cde3e2c508b05133afffaa0
Public key: 0x066be9d2df098aee5b1d410148e3aeee6f0946d898a6aa68747d486f36479c7f
Transaction hash: 0x6951f95eabdb2eac42bb3c09f507fb3b15eb65895486511856ce578db84a5bf
```

# usage

always make source to initialize the python venv before working:

```shell
$> python3.7 -m venv ~/cairo_venv
```


# resources

* [how cairo works](https://www.cairo-lang.org/docs/how_cairo_works/index.html#how-cairo-works)
* [hello cairo](https://www.cairo-lang.org/docs/hello_cairo/index.html#hello-cairo)
* [writing starknet contracts](https://www.cairo-lang.org/docs/hello_starknet/intro.html)
* [cairo resource guide](https://www.cairo-lang.org/resource-guide/)
* [stark 101](https://starkware.co/stark-101/)
* [what is starknet](https://starknet.io/what-is-starknet/)
* [building on starknet](https://starknet.io/building-on-starknet/)
* [cairo memory model](https://www.cairo-lang.org/docs/how_cairo_works/cairo_intro.html#memory-model)
* [cairo builtins](https://www.cairo-lang.org/docs/how_cairo_works/builtins.html#builtins)

## misc

* https://github.com/exothium/Cairo
* https://github.com/bonedaddy/cairo-learning
* https://github.com/abigger87/cairopal
* https://github.com/abigger87/cairostarter
* https://github.com/abigger87/cairo-by-example
* https://github.com/sambarnes/fullstack-starknet
* https://github.com/abigger87/cairomate

## suggested learning path

If you want a more hands on approach start with [hello cairo](https://www.cairo-lang.org/docs/hello_cairo/index.html#hello-cairo), otherwise if you want a more technical / in-depth approach start with [how cairo works](https://www.cairo-lang.org/docs/how_cairo_works/index.html#how-cairo-works).

It's probably a good idea to start with the [syntax documentation](https://www.cairo-lang.org/docs/reference/syntax.html) as well