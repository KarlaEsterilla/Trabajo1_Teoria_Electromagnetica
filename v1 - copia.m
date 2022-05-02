clc
clear all
clf
fila=0;
columna=0;
Datos = [];
str=0;

while 1
    
carga = input('carga   ');
if isempty(carga)
    break
end

fila=fila+1;
Datos(fila,1)=carga;
vector=input('vector posicion   ');
Datos(fila,2)=vector(1);
Datos(fila,3)=vector(2);

end


[X,Y] = meshgrid(min(Datos(:,2))-1:pi/22:max(Datos(:,2))+1,min(Datos(:,3))-1:pi/22:max(Datos(:,3))+1);
[num_cargas,o]=size(Datos)

Ex_neto=0;
Ey_neto=0;
E_neto=0;

for i=1:num_cargas
    
  Q=Datos(i,1);
  Rx = X - Datos(i,2);
  Ry = Y - Datos(i,3);
  
  R = sqrt(Rx.^2 + Ry.^2).^3;
  
  Ex = 1/(4*pi*8.854e-12).* Q .*Rx ./ R;
  Ey = 1/(4*pi*8.854e-12).* Q .*Ry ./ R;
   
  E = sqrt(Ex.^2 + Ey.^2);
  
  Ex_neto=Ex_neto+Ex;
  Ey_neto=Ey_neto+Ey; 
  E_neto=E_neto+E;
  
end


figure(1);


campo_vectorial = quiver(X,Y,Ex_neto./E_neto,Ey_neto./E_neto);



a = linspace(min(Datos(:,2))-1,max(Datos(:,2))+1);
b = linspace(min(Datos(:,3))-1,max(Datos(:,3))+1);
[X,Y] = meshgrid(a,b);

%V
voltaje_neto=0;

for i=1:num_cargas
  
    Q=Datos(i,1);
    
    
    Rx = X - Datos(i,2);
    Ry = Y - Datos(i,3);
  
    R = sqrt(Rx.^2 + Ry.^2);
    
    voltaje=(1/(4*pi*8.854e-12)).*Q ./R;
    
    voltaje_neto=voltaje_neto+voltaje;
    
end

figure(2);
mapa_calor=pcolor(X,Y,voltaje_neto);

mapa_calor.EdgeColor='none';
mapa_calor.FaceColor='interp';
shading interp;
colormap(copper)

%E
voltaje_neto=0;
a = linspace(min(Datos(:,2))-1,max(Datos(:,2))+1);
b = linspace(min(Datos(:,3))-1,max(Datos(:,3))+1);
[X,Y] = meshgrid(a,b);

for i=1:num_cargas
  
    Q=Datos(i,1);
    
    
    Rx = X - Datos(i,2);
    Ry = Y - Datos(i,3);
  
    R = sqrt(Rx.^2 + Ry.^2);
    
    voltaje=(1/(4*pi*8.854e-12)).*Q ./R;
    
    voltaje_neto=voltaje_neto+voltaje;
    
end


figure(3);
contour(X,Y,voltaje_neto,400);

