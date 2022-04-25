# shartnet_startkit

![](./assets/meme.png)

A small, dependency-less starter kit for working with the Cairo programming language on *nix machine, including notes, and a currated resource index for getting started with Starknet.

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

Afterwards you can point `scripts/run.sh` to an uncompile cairo file which will be compiled to a temporary location and ran, or you can point it to a compile cairo file which will be executed:

```shell
$> ./scripts/run.sh hello_cairo/array_sum.cairo
[WARN] detected uncompiled cairo file, compiling to temporary location
Program output:
  48

Number of steps: 179 (originally, 179)
Used memory cells: 409
Register values after execution:
pc = 413
ap = 389
fp = 413

[WARN] cleaning up temporary files

```

# resources

See [RESOURCES.md](./docs/RESOURCES.md)
