clc; clear all; close all;
load InputA.dat

girisler= [1 5 8 10 12 14];    

    B=randperm(297);
    egitimsecim = B(1:200);
    %200x1 olarak gösterimi
    egitim = egitimsecim(:);
    %%egitimsecim değerleri dısındaki degerleri testsecime alıyoruz. 1x97
    testsecim = setdiff(B,egitimsecim);
    %97x1 
    test = testsecim(:);
    
    %testverisi için InputA'dan değerler alındı.
    testverisi=[];
    for a=1:1
        for e=1:length(test)
            testverisi=[testverisi; InputA(test(e),:)];
        end
    end
    
    %t_veri'den sort_random_input'un istediği sütunlara göre veriler alındı.
    test_veri = [];
    for t=1:length(girisler)
        test_veri = [test_veri testverisi(:,girisler(t))];
    end
   