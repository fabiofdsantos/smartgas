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

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run()
    {
        Model::unguard();

        $this->call('BrandsTableSeeder');
        $this->call('TypesTableSeeder');
        $this->call('DistrictsTableSeeder');
        $this->call('MunicipalitiesTableSeeder');
        $this->call('StationsTableSeeder');
        $this->call('PricesTableSeeder');

        Model::reguard();
    }
}
