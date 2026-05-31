clear; clc; close all;

% verileri oku
para_ilk = 10000;
egitim = readtable(fullfile("data","egitim_verisi.csv"));
test = readtable(fullfile("data","test_verisi.csv"));
tarih = datetime(test.Date,"InputFormat","yyyy-MM-dd");

% egitim verisiyle en iyi rsi sinirini sec
en_iyi_rsi = rsi(egitim.Close, para_ilk);

% test verisi icin hesaplamalar
fiyat = test.Close;
kisa = movmean(fiyat, [2 0]);
uzun = movmean(fiyat, [99 0]);
r = rsi(fiyat);

para = para_ilk; adet = 0; pozisyon = false;
portfoy = ones(length(fiyat),1) * para_ilk;
al_nokta = false(length(fiyat),1);
sat_nokta = false(length(fiyat),1);
dosya = fopen("islemler.txt","w");
fprintf(dosya,"Secilen RSI: %d\nIslemler:\n", en_iyi_rsi);

% test verisinde al sat yap
for i = 101:length(fiyat)
    al = kisa(i) > uzun(i) && kisa(i-1) <= uzun(i-1) && r(i) < en_iyi_rsi;
    sat = kisa(i) < uzun(i) && kisa(i-1) >= uzun(i-1);

    if al && pozisyon == false
        adet = para / fiyat(i); para = 0; pozisyon = true;
        al_nokta(i) = true;
        fprintf(dosya,"AL  %s  %.2f\n",string(tarih(i)),fiyat(i));
    elseif sat && pozisyon == true
        para = adet * fiyat(i); adet = 0; pozisyon = false;
        sat_nokta(i) = true;
        fprintf(dosya,"SAT %s  %.2f\n",string(tarih(i)),fiyat(i));
    end
    portfoy(i) = para + adet * fiyat(i);
end

strateji = para + adet * fiyat(end);
al_tut = para_ilk * fiyat(end) / fiyat(1);
fprintf("RSI: %d  Strateji: %.2f  Al-tut: %.2f\n", en_iyi_rsi, strateji, al_tut);

fprintf(dosya,"\nStrateji: %.2f\nAl-tut: %.2f\n", strateji, al_tut);
if pozisyon
    fprintf(dosya,"son pozisyon hala acik\n");
end
fclose(dosya);

% grafik
figure;
subplot(2,1,1);
plot(tarih,fiyat,"w"); hold on;
plot(tarih,kisa,"c");
plot(tarih,uzun,"y");
plot(tarih(al_nokta),fiyat(al_nokta),"g^","MarkerFaceColor","g");
plot(tarih(sat_nokta),fiyat(sat_nokta),"rv","MarkerFaceColor","r");
title("fiyat ve islemler");
legend("kapanis","3 ort","100 ort","AL","SAT");
grid on;
subplot(2,1,2);
plot(tarih,portfoy,"c");
title("portfoy"); grid on;