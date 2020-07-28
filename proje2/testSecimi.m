clc; clear all; close all;
load InputA.dat

girisler= [1 5 8 10 12 14];    

    B=randperm(297);
    egitimsecim = B(1:200);
    %200x1 olarak g�sterimi
    egitim = egitimsecim(:);
    %%egitimsecim de�erleri d�s�ndaki degerleri testsecime al�yoruz. 1x97
    testsecim = setdiff(B,egitimsecim);
    %97x1 
    test = testsecim(:);
    
    %testverisi i�in InputA'dan de�erler al�nd�.
    testverisi=[];
    for a=1:1
        for e=1:length(test)
            testverisi=[testverisi; InputA(test(e),:)];
        end
    end
    
    %t_veri'den sort_random_input'un istedi�i s�tunlara g�re veriler al�nd�.
    test_veri = [];
    for t=1:length(girisler)
        test_veri = [test_veri testverisi(:,girisler(t))];
    end
   