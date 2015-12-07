<?php

/*
 * This file is part of SmartGas, an iOS app to find the best gas station nearby.
 *
 * (c) Fábio Santos <ffsantos92@gmail.com>
 * (c) Mateus Silva <mateusgsilva_@hotmail.com>
 * (c) Fábio Marques <fabio1956.epo@gmail.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

$app->get('/', function () use ($app) {
    return $app->welcome();
});

/* Brands */
$app->get('brands', 'BrandController@index');
$app->get('brands/{id}', 'BrandController@show');

/* Districts */
$app->get('districts', 'DistrictController@index');
$app->get('districts/{id}', 'DistrictController@show');

/* Municipalities */
$app->get('municipalities', 'MunicipalityController@index');
$app->get('municipalities/{id}', 'MunicipalityController@show');

/* Stations */
$app->get('stations', 'StationController@index');
$app->get('stations/{id}', 'StationController@show');

/* Types */
$app->get('types', 'TypeController@index');
$app->get('types/{id}', 'TypeController@show');
