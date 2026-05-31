function en_iyi_rsi = rsi(fiyat, para_ilk)
    % rsi degeri hesaplanir
    fark = [0; diff(fiyat)];
    artis = max(fark, 0); 
    azalis = abs(min(fark, 0));
    ort_artis = movmean(artis, [13 0]);
    ort_azalis = movmean(azalis, [13 0]);
    r = 100 - (100 ./ (1 + ort_artis ./ ort_azalis));
    r(ort_azalis == 0) = 100;

    if nargin == 1
        en_iyi_rsi = r;
        return
    end

    % egitim verisinde en iyi rsi siniri secilir
    aday = 68:2:80;
    en_iyi_para = 0;
    en_iyi_rsi = aday(1);
    kisa = movmean(fiyat, [2 0]);
    uzun = movmean(fiyat, [99 0]);

    for j = 1:length(aday)
        para = para_ilk; adet = 0; pozisyon = false;

        for i = 101:length(fiyat)
            al = kisa(i) > uzun(i) && kisa(i-1) <= uzun(i-1) && r(i) < aday(j);
            sat = kisa(i) < uzun(i) && kisa(i-1) >= uzun(i-1);
            if al && pozisyon == false
                adet = para / fiyat(i); para = 0; pozisyon = true;
            elseif sat && pozisyon == true
                para = adet * fiyat(i); adet = 0; pozisyon = false;
            end
        end

        son = para + adet * fiyat(end);
        if son > en_iyi_para
            en_iyi_para = son;
            en_iyi_rsi = aday(j);
        end
    end
end
