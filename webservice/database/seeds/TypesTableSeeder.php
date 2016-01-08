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

class TypesTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('types')->delete();

        $types = [
            [
                'value' => 'Diesel simple',
                'created_at' => \Carbon\Carbon::now(),
                'updated_at' => \Carbon\Carbon::now(),
            ],
            [
                'value' => 'Diesel',
                'created_at' => \Carbon\Carbon::now(),
                'updated_at' => \Carbon\Carbon::now(),
            ],
            [
                'value' => 'Diesel special',
                'created_at' => \Carbon\Carbon::now(),
                'updated_at' => \Carbon\Carbon::now(),
            ],
            [
                'value' => 'Diesel colorful',
                'created_at' => \Carbon\Carbon::now(),
                'updated_at' => \Carbon\Carbon::now(),
            ],
            [
                'value' => 'Gasoline simple 95',
                'created_at' => \Carbon\Carbon::now(),
                'updated_at' => \Carbon\Carbon::now(),
            ],
            [
                'value' => 'Gasoline 95',
                'created_at' => \Carbon\Carbon::now(),
                'updated_at' => \Carbon\Carbon::now(),
            ],
            [
                'value' => 'Gasoline special 95',
                'created_at' => \Carbon\Carbon::now(),
                'updated_at' => \Carbon\Carbon::now(),
            ],
            [
                'value' => 'Gasoline 98',
                'created_at' => \Carbon\Carbon::now(),
                'updated_at' => \Carbon\Carbon::now(),
            ],
            [
                'value' => 'Gasoline special 98',
                'created_at' => \Carbon\Carbon::now(),
                'updated_at' => \Carbon\Carbon::now(),
            ],
            [
                'value' => 'LPG',
                'created_at' => \Carbon\Carbon::now(),
                'updated_at' => \Carbon\Carbon::now(),
            ],
            [
                'value' => 'LNG',
                'created_at' => \Carbon\Carbon::now(),
                'updated_at' => \Carbon\Carbon::now(),
            ],
        ];

        DB::table('types')->insert($types);
    }
}
