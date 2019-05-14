# Decentralized Planning in the *asprilo* Framework

A centralized version based on the same python framework using the same planning encoding (but it only works for instances where the number of robots equals the number of robots) for comparing the decentralized approach.

## Structure

**Python control structure**

pathfind.py - The general python framework distributing orders, simulating the plan execution and resolving conflicts 

robot.py - Implements functionality for the robots (planning using the [**clingo**](<https://github.com/potassco/clingo>) module)

Both files are modified versions of the master branch (the decentralized version).

**Planning encodings**

pathfind.lp - The general planning encoding 

This is the same encoding as used in the decentralized version.

## Instance Format


The input format is the normal [**asprilo format**](<https://github.com/potassco/asprilo/blob/master/docs/specification.md#input-format>) (for domain A). However product quantities are ignored (but need to be specified in the input).

Additionally a horizon for the instance has to be provided by a fact `time(1..N).`

The output format follows the [**asprilo format**](<https://github.com/potassco/asprilo/blob/master/docs/specification.md#output-format>) for domain B.

## Usage

Python (tested with version 2.7) and the python module of [**clingo**](<https://github.com/potassco/clingo>) are required.
