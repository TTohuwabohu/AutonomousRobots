# Decentralized Planning in the *asprilo* Framework

A centralized version based on the same python framework using the same planning encoding (but it only works for instances where the number of robots equals the number of robots).

## Structure

**Python control structure**

pathfind.py - The general python framework 

robot.py - Implements functionality for the robots

Both files are modified versions of the master branch (the decentralized version)

**Planning encodings**

pathfind.lp - The general planning encoding 

This is the same encoding as used in the decentralized version 

## Instance Format

The input and output format is the normal [**asprilo**](<https://potassco.org/asprilo>) format.
Additionally a horizon for the instance is required given by `time(1..N).`

## Usage

