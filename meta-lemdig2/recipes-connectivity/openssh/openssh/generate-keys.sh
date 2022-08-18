#!/bin/sh
rm keys/*
ssh-keygen -t rsa -f keys/ssh_host_rsa_key -N '' -C 'lemsdr'
ssh-keygen -t dsa -f keys/ssh_host_dsa_key -N '' -C 'lemsdr'
ssh-keygen -t ecdsa -f keys/ssh_host_ecdsa_key -N '' -C 'lemsdr'
ssh-keygen -t ed25519 -f keys/ssh_host_ed25519_key -N '' -C 'lemsdr'
