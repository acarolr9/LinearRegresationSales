# Predicción de ventas
## **Comprensión del negocio**
### Determinar los objetivos del negocio
#### *Contexto*
La industria de la moda en Colombia aporta el 1.13% del PIB y participa con el 10.3% de la industria colombiana (textil, confección, calzado y marroquinería). Las exportaciones en 2017 alcanzaron los US $ 769 millones y las importaciones sumaron US $ 2.208 millones (Brand, 2018). De los cuales un 9% de las ventas totales se realizan por otros canales diferentes a la tienda física, en ventas online la venta de ropa equivale 6,9% del total de compras hechas online. 

![Tomado de: https://www.larepublica.co/internet-economy/la-venta-de-ropa-representa-69-de-lo-que-mueve-el-comercio-electronico-2771235](005.png)

Tomado de: <https://www.larepublica.co/internet-economy/la-venta-de-ropa-representa-69-de-lo-que-mueve-el-comercio-electronico-2771235>

De igual manera el 48% de la compra de ropa, calzado y accesorios corresponde mujeres entre una edad de 25 y 35 años en el cual el pico de compra online es de 43% correspondiente entre 100.000 y 300.000 pesos de gasto anual donde la compra más frecuente es calzado (Castañeda, 2017).

Los pronósticos de demanda son herramientas de que permiten reducir la incertidumbre del futuro mediante la anticipación de eventos. Con el fin de apoyar la toma de decisiones y prepararse ante estos eventos. Lo cual involucra costos con respecto a materias primas, transporte y administrativos

Finalmente, cuando se habla de la planificación de las ventas en compañías de venta por catálogo se inicia desde el área de mercadeo, e impactan directamente el área de la cadena de suministros, en función de tener la disponibilidad de los productos mientras sea la duración del catálogo vigente. Estos escenarios generan inconvenientes importantes de logística, cada vez que se presentan unas ventas superiores o inferiores a las estimadas. Produce inconvenientes como la generación de excesos y/o falta de inventario, así como también hacer estimaciones no adecuadas con relación a los ingresos esperados. Ambos escenarios indeseables impactan directamente el sistema de ventas, y se trasladan al consumidor final a través de las vendedoras o consultoras independientes, y generan problemas de imagen y marca (Boada & Mayorca, 2011).
#### *Objetivos del negocio*
- Realizar un pronóstico de ventas anual para la ropa de mujer basado en la información de la sucursal.
- Contar con los recursos necesarios para cumplir la demanda de cada zona.
#### *Criterios de éxito del caso*
Establecer el modelo de regresión que permita predecir la demanda de ropa para mujer en cada sucursal dependiendo de la información de esta.

### Determinar objetivos de la minería de datos
Como objetivo principal del modelo se desea predecir las compras de ropa para mujer, con menor error cuadrático medio posible.
### Criterios de éxito
Lograr una predicción que supere el benchmark ingenuo de los datos de prueba.
## **Comprensión de datos**
### Sentido del negocio
Teniendo en cuenta el interés de la compañía en conocer la demanda de ropa para mujer dependiendo, de sus las características de la tienda se evalúa el comportamiento de la variable respuesta, así como su correlación con otras variables como se muestra a continuación:

![](006.png)

![](007.png)

Adicionalmente, se valida los resultados de los estadísticos descriptivos de las variables numéricas donde se puede ver que la cantidad de ropa comprada tiene una distribución asimétrica positiva con una cola derecha ligeramente más alargada, y un promedio de ventas por sucursal de 40.818 unidades. Esta variable también esta correlacionada con la mayoría de las variables de la base excluyendo los años transcurridos desde que la llegada a la zona. En la matriz de correlación también se evidencia que las variables sobre el tipo de mercado a atacar y número de representantes de servicio al cliente esta altamente correlacionados. De lo que se podría inferir para un estudio posterior, la posible combinación entre las variables. 

![](008.png)

Para las demás variables también se valida el comportamiento de las demás variables, tanto numéricas como categóricas como se muestra a continuación, en donde se evidencia que ninguna de las variables de la data tiene valores faltantes, ni destacablemente atípicos.  Con respecto al análisis de los datos categóricos resalta que la variable promo no presentar variabilidad significativa entre categorías, que la mayoría de las sucursales son tipo de mercado 1 y 5, y que la mayoría de las sucursales presentan un tamaño de grande de potencial de mercado. 

![](009.png)![](010.png)

![](011.png)![](012.png)

![](013.png)![](014.png)![](015.png)![](016.png)

![](017.png)

## **Preparación de datos**
### Estructuración de los datos
Dado que lo que se busca a raves del estudio del caso es encontrar un modelo de regresión lineal en base a las características que presentan las sucursales de ventas de ropa por catálogo, el primer paso de la preparación de los datos es hacer la numerización 1 a n de las variables categóricas. En este caso se convirtió la variable tamaño y promo en tres variables que corresponde a los niveles de las variables. Posterior a esto se elimino una de las columnas de cada variable (tamaño de mercado pequeño y promo 3) con el fin de combatir la multicolinealidad entre variables que puede generar este tipo de procesos de estructuración de datos. 
### Formateo de los datos
Para obtener la base final con la cual se planea entrenar los modelos de regresión se elimina la variable idloc de la base de datos de preparación, debido a que, esta es una variable de identificación de la sucursal, más no, una variable que pueda ser de influencia para el objetivo del caso.
## **Modelado**
### Generación de un plan de prueba
Con el fin de encontrar el modelo que puede ser utilizado en la predicción del volumen de ropa comprado para cualquier sucursal se decide realizar un primer modelo que incluya todas las variables en su forma natural, y partir de los resultados que se obtengan de este, evaluar la posibilidad u ventaja de generar transformaciones sobre las variables o reducir variables para evitar problemas de Overfitting. Adicionalmente, se validarán los modelos generados con respecto a la predicción ingenua. 
### Construcción del modelo
Se realiza el primer acercamiento a una solución utilizando todas las variables del modelo si realizar ninguna transformación, y se obtienen los siguientes resultados:

|**Modelo**|**Variables** |**R2**|**R2 Ajustado**|**AIC**|**F-sta**|**F-Sta (p-value)**|**Error**|
| :- | :- | :- | :- | :- | :- | :- | :- |
|**Todas las variables**|11|0\.7292|0\.6953|1771\.11|21\.54|2\.2e-16|6631|

Coefficients:

`                   `Estimate Std. Error t value Pr(>|t|)    

(Intercept)     -3.795e+04  1.129e+04  -3.362  0.00115 \*\* 

correo            1.789e+00 5.742e-01   3.115  0.00248 \*\* 

páginas           2.022e+02 5.576e+01   3.627  0.00048 \*\*\*

teléfono          2.435e+02 1.312e+02   1.856  0.06677 .  

impresa           8.811e-01 2.030e-01   4.340 3.80e-05 \*\*\*

servicio          6.761e+02 1.262e+02   5.358 6.67e-07 \*\*\*

idmercado        -1.756e+03 5.622e+02  -3.124  0.00242 \*\* 

tamañomer. Grande -4.063e+02  2.068e+03  -0.196  0.84474    

tamañomer. Median -1.333e+03  2.405e+03  -0.554  0.58066    

edadloc           2.179e+01 1.159e+02   0.188  0.85138    

promo            -7.384e+02 8.419e+02  -0.877  0.38286    

nomina           -1.861e-01 2.651e-01  -0.702  0.48460 


![](018.png)

Aunque el modelo presenta un mínimo nivel de validez predictiva para el caso estudiado por los resultados del modelo, cuando se evalúan las pruebas de hipótesis t individuales para cada variable independiente (Pr > |t|), se evidencia que la mayoría de las variables en realidad no tienen una importancia significativa en la predicción de modelo. También se encuentra que el modelo presenta un error promedio de 6.631 en sus predicciones de y logra explicar un 72% de la variabilidad de las predicciones, sin embargo, el hecho de que el modelo tenga variables poco significativas y que cuando se calcula el r ajustado disminuya el porcentaje de explicación de variabilidad indica que la predicción tiene el riesgo de estar inflada por el overfitting. 

Al evaluar los gráficos de residuos se encuentra que para la validación de los residuos vs la curva norma (Q-Q) no corresponde con los valores de residuos encontrados principalmente en la esquina inferior derecha por lo que es probable que el modelo no cumpla con el supuesto de normalidad. Aunque parece cumplir los supuestos de homocedasticidad y no correlación de residuos, aunque se pueden observar que algunos de los datos se registran como atípicos.

En base a esto se decide utilizar un método de selección de variables que permita reducir la cantidad de variables del modelo actual y ver su influencia en los resultados. Como se muestra a continuación:

|**Modelo**|**Variables** |**R2**|**R2 Ajustado**|**AIC**|**F-sta**|**F-Sta (p-value)**|**Error**|
| :- | :- | :- | :- | :- | :- | :- | :- |
|**Todas las variables**|6|0\.7249|0\.7072|1762\.67|40\.85|2\.2e-16|6500|

Coefficients:

`              `Estimate Std.Error  tvalue Pr(>|t|)    

(Intercept) -4.572e+04 7.239e+03  -6.316 9.12e-09 \*\*\*

correo       1.905e+00 5.481e-01   3.476 0.000776 \*\*\*

páginas      2.058e+02 5.430e+01   3.791 0.000266 \*\*\*

teléfono     2.260e+02 1.247e+02   1.813 0.073109 .  

impresa      9.013e-01 1.956e-01   4.608 1.29e-05 \*\*\*

servicio     6.678e+02 1.214e+02   5.500 3.31e-07 \*\*\*

idmercado   -1.571e+03 5.003e+02  -3.140 0.002264 \*\* 

![](019.png)

Aunque el nuevo modelo, parece ser mas preciso en cuanto al porcentaje de variabilidad de la predicción que logra explicar aun no presenta mejora en los resultados de validación de supuestos, por lo cual se decide estudiar la relación funcional entre las predicciones estándar vs los residuos.

![](020.png)![](021.png)![](022.png)![](023.png)![](024.png)![](025.png)![](026.png)

Se observa que en la mayoría de los casos no existe una relación obvia entre la distribución de los residuos, y la variable predictora, sim embargo, se pueden observar algunas anomalidades en las variables de correo, edadloc y teléfono que nos sugieren validar posibles trasformaciones.

En base a esto y a los resultados de la exploración inicial de datos se decide empezar a trabajar con diferentes modelos que incluyen una o más transformaciones en todos los casos primero se genera un modelo con todas las variables y a continuación se aplica el método de stepwise para reducir el número de variables.

|**Modelo**|**Variables** |**R2**|**R2 Ajustado**|**AIC**|**F-sta**|**F-Sta (p-value)**|**Error**|
| :- | :- | :- | :- | :- | :- | :- | :- |
|**Númerizando variable mercado** |11|0\.7331|0\.6998|1769\.63|21\.98|2\.2e-16|6582|
|**Raíz del correo**|6|0\.7257|0\.708||41\.01|2\.2e-16|6491|
|**Logaritmo del correo**|6|0\.725|0\.7073||40\.87|2\.2e-16|6499|
|**Correo cuadrado**|5|0\.7257|0\.7111||49\.7|2\.2e-16|6457|
|<a name="_hlk5356062"></a>**Correo cuadrado y idmercado multiplicado por teléfono**|6|0\.7321|0\.7149||42\.37|2\.2e-16|6414|
|**Edad al cubo**|7|0\.7397|0\.7199||37\.35|2\.2e-16|6357|
|**Edad al cubo y correo al cuadrado**|7|<p>0\.7379</p><p></p>|0\.718|1759\.82|<p>37\.01</p><p></p>|2\.2e-16|<p>6379</p><p></p>|

Como se puede observar se encontraron resultados que disminuyeron el error generado, así como el R y R ajustado. 

### Evaluación del modelo
Para la evaluación del modelo se decide evaluar los resultados de los modelos de stepwise:

- Todas las variables
- Raíz correo
- Cuadrado correo
- Correo cuadrado y idmercado multiplicado por teléfono
- Edad al cubo
- Edad al cuadrado y correo al cuadrado

Esta validación se realizo por medio de la plataforma de Kaggle en la cual se mide el error cuadrático de los resultados frente al 30% de los resultados de prueba. Al realizar este análisis se encontró que el error mas grande esta en el modelo de todas las variables seguido por, el cuadrado del correo, la raíz del correo, el correo cuadrado, el id mercado por el teléfono, el de edad al cubo y el de correo y edad al cuadrado ordenados de mayor a menor error. De manera que el mínimo erro fue el del modelo con las variables edad y correo al cuadrado.

Este modelo genero un error cuadrático de 5260.81 frente a los resultados de prueba siendo el único junto con el de edad al cubo que supera el error del pronóstico ingenuo.

## **Evaluación** 
### Evaluación de los resultados
El modelo final sugerido entonces es el modelo de edad y correo al cuadrado, el cual presenta los siguientes resultados:

Call:

lm(formula = ropamujer ~ páginas + impresa + servicio + idmercado +

edadloc + CorreoCuadrado + EdadCuadrado, data = Variablefin2.2)

Residuals:

Min     1Q Median     3Q    Max

-23294  -2325   1247   3255  13545

Coefficients:

Estimate Std. Error t value Pr(>|t|)

(Intercept)    -2.803e+04  6.838e+03  -4.099 8.92e-05 \*\*\*

páginas         1.992e+02  5.267e+01   3.782 0.000276 \*\*\*

impresa         8.632e-01  1.933e-01   4.466 2.26e-05 \*\*\*

servicio        5.199e+02  1.295e+02   4.013 0.000122 \*\*\*

idmercado      -1.188e+03  4.498e+02  -2.641 0.009712 \*\*

edadloc        -7.271e+02  3.845e+02  -1.891 0.061784 .

CorreoCuadrado  1.629e-04  3.256e-05   5.002 2.71e-06 \*\*\*

EdadCuadrado    3.453e+01  1.680e+01   2.055 0.042720 \*

\---

Signif. codes:  0 ‘\*\*\*’ 0.001 ‘\*\*’ 0.01 ‘\*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 6379 on 92 degrees of freedom

Multiple R-squared:  0.7379,	Adjusted R-squared:  0.718

F-statistic: 37.01 on 7 and 92 DF,  p-value: < 2.2e-16

![](027.png)

En donde se comprueba que el modelo final sigue presentando errores de normalidad, pero presenta valores que superan el benchmark ingenuo

## **Implementación**
### Informe final
Teniendo en cuenta los objetivos del negocio de establecer el modelo de regresión que permita predecir la demanda de ropa para mujer en cada sucursal dependiendo de la información de esta. Se puede determinar que el modelo generado el que cumple con la ecuación.

Ropa Mujer = 199,23páginas + 0,86impresa + 519,87servicio - 1188idmercado - 727,1edadloc + 0,0002CorreoCuadrado + 34,53EdadCuadrado  - 28032,44

La cual tiene el siguiente comportamiento con los resultados de entrenamiento:

![](028.png)

En el cual, aunque el modelo logra disminuir el error de la predicción mejor que los demás modelos ajustados, permitiendo un porcentaje de predicción de la variabilidad del 73,8% aproximadamente, al evaluar los resultados de los residuos vs la variable a predecir se puede observar que el modelo tiene un desempeño de respuestas bueno para sucursales en las que las ventas de ropa superan las 30.000 unidades, pero tiende a predecir sobrestimar la demanda en las sucursales de baja demanda.

Aunque el error general es alto si consideramos que representa el 16 % del promedio de ventas, cuando se excluyen del modelo las sucursales que venden menos de 30.000 unidades, encontramos que, error cuadrático medio 4.860 que solo es el 12% del promedio, de manera que el modelo funciona para predecir 88% del volumen de venta por lo que se puede asumir que es un modelo de predicción bueno que adicionalmente como ya se estudió verifico por medio del concurso en Kaggle sirve para predecir datos nuevos con un error cuadrático de 5.260 y es más acertado que pronostico ingenuo.

Cumpliendo así el objetivo principal, sin embargo, como ya se ha mencionado anteriormente sería importante tener precaución con las predicciones en sucursales que no tengan una alta demanda, esto se podrá validar mirando el total de compras por catálogo de toda la sucursal o evaluando la posible inclusión de otra variable no presente en la base original que ayude a modelar este comportamiento, con el fin de evitar incurrir en costos adicionales de transporte y almacenamiento de inventarios.

Aun así, se evidencia que en 65% de los casos se predijo por encima de la demanda lo que indica que el modelo, tiende a sobrestimar lo demando por lo que, en la mayoría de los casos, aunque se puedan generar costos no se esta afectando la calidad del servicio prestado a los clientes por inventario insuficiente y demoras en entregas.  Lo cual puede ser favorable dependiendo el enfoque de la organización hacia al futuro.

## **Referencias**
Boada, Antonio José, & Mayorca, Rómulo. (2011). Planificación de demanda, en empresas con estilo de venta por catálogo. *Revista Lasallista de Investigación*, *8*(2), 124-135. Retrieved March 26, 2019, from <http://www.scielo.org.co/scielo.php?script=sci_arttext&pid=S1794-44492011000200014&lng=en&tlng=es>.

Arias, Ferney. (2018). El cara y sello del sector textil-confección en 2018. El colombiano. Recuperado de http://www.elcolombiano.com/negocios/asi-cierra-el-ano-el-sector-textil-confeccion-en-colombia-IF979920

Cubillos, Natalia. (2018). La mitad de las empresas apuesta por inversiones. El colombiano. Recuperado de <http://www.elcolombiano.com/negocios/economia/la-mitad-de-las-empresas-hara-inversiones-en-2019-FA9736171>

Vega, Juan Pablo. (2018). La venta de ropa representa 6,9% de lo que mueve el comercio electrónico. La República. Recuperado de <https://www.larepublica.co/internet-economy/la-venta-de-ropa-representa-69-de-lo-que-mueve-el-comercio-electronico-2771235>



