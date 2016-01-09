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

use Illuminate\Database\Seeder;

class MunicipalitiesTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('municipalities')->delete();

        $leiria_district_id = app('db')->table('districts')->where('value', 'Leiria')->pluck('id');

        $municipalities = [
            [
                'value'       => 'Leiria',
                'district_id' => $leiria_district_id,
                'created_at'  => \Carbon\Carbon::now(),
                'updated_at'  => \Carbon\Carbon::now(),
            ],
        ];

        DB::table('municipalities')->insert($municipalities);
    }
}
