%% 
% This script comprises of step by step calls to finally run the quant.m
% function.

%%
% Clearing the workspace
clear all;
close all;
clc;

%%
% Reading the input from *.mat file
temp = load('x.mat');
input = temp.c;

%%
% Defining other parameters
steps = 32;
maxv = 2;

%%
disp('Calling quant with the following parameters.');

display(steps);
display(maxv);

quant(input, steps, maxv);

