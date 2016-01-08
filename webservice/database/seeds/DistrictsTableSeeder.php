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

class DistrictsTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('districts')->delete();

        $districts = [
            [
                'value' => 'Leiria',
                'created_at' => \Carbon\Carbon::now(),
                'updated_at' => \Carbon\Carbon::now(),
            ],
        ];

        DB::table('districts')->insert($districts);
    }
}
