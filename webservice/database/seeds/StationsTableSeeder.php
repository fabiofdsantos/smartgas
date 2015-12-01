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

class StationsTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('stations')->delete();

        $stations = [
            'title'           => 'E.S. Leiria Sul',
            'address'         => 'Rot. Variante 2400-140 - Leiria - Qtª da Taborda',
            'latitude'        => '39.73564',
            'longitude'       => '-8.79968',
            'brand_id'        => app('db')->table('brands')->where('value', 'Repsol')->pluck('id'),
            'schedule_id'     => null,
            'district_id'     => app('db')->table('districts')->where('value', 'Leiria')->pluck('id'),
            'municipality_id' => app('db')->table('municipalities')->where('value', 'Leiria')->pluck('id'),
            'created_at'      => \Carbon\Carbon::now(),
            'updated_at'      => \Carbon\Carbon::now(),
        ];

        DB::table('stations')->insert($stations);
    }
}
