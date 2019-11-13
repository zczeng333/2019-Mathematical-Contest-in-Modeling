function weight = gauss(center,points)
    mu = center;
    sigma = [50,0;0,50];
    haha = mvnpdf(points,mu,sigma);
    wahaha = sum(haha);
    weight = haha/wahaha;
end