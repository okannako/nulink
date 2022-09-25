<p align="center">  
  <a ><img src="https://user-images.githubusercontent.com/73176377/192120292-a2d37748-1d5f-4ec9-9048-057951911801.png"
width=45%
</p>

### NuLink Ödüllü Testnet Node Sistem Gereksinimleri
 - Ubuntu 20.04
 - 4 GB RAM
 - 30 GB HDD
 - işlemci olarak kaynak dosyalarda net bir açıklamaya yok ama önerim 2CPU
 
### Kurulum Rehber Videosu
 - 
 
### Node Kurulum Adımları
- Video ile birlikte paralel giderseniz daha rahat kurulum yaparsınız.
- Öncelikle Contabo, Hetzner, Linode, Digital Oceon gibi portların açık olduğu vps sağlayıcıları dışında kurulum yapacaksanız. Alttaki kodlarla ya da sağlayıcının kendi sitesinden 9151 portunu açmalısınız.
```
sudo ufw enable
sudo ufw allow 9151
```

1.) Aşağıdaki tek kodu yapıştıyoruz. Bazı noktalarda sizden değer girmenizi isteyecek, şifre, kelimler gibi ve belirli çıktılar verecek. Hepsini kesinlikle bir yere kaydedin, ilerde lazım olma ihtimali çok yüksek.
```
wget -q -O nulink.sh https://raw.githubusercontent.com/okannako/nulink/main/nulink.sh && chmod +x nulink.sh && sudo /bin/bash nulink.sh
```

2.) Kurulumda bize verdiği çıktıyı (herkeste farklı) ``/root/geth-linux-amd64-1.10.24-972007XXXXX`` aşağıdaki kodda yerine yazıyoruz
```
cp /root/geth-linux-amd64-1.10.24-972007XXXXX /root/nulink
```

3.) Yetki veriyoruz.
```
chmod -R 777 /root/nulink
```

4.) Şifre ataması yapıyoruz. Lütfen tek kodu çalıştırdığımızda verdiğiniz aynı şifreyi burada SİZİNSİFRE bölümüne yazın.
```
export NULINK_KEYSTORE_PASSWORD=SİZİNSİFRE
export NULINK_OPERATOR_ETH_PASSWORD=SİZİNSİFRE
```

5.)
