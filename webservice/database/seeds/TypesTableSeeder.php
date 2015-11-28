<?php

/*
 * This file is part of SmartGas,
 * an iOS app to find the best gas station nearby.
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
            ['value' => 'Diesel simple'],
            ['value' => 'Diesel'],
            ['value' => 'Diesel special'],
            ['value' => 'Diesel colorful'],
            ['value' => 'Gasoline simple 95'],
            ['value' => 'Gasoline 95'],
            ['value' => 'Gasoline special 95'],
            ['value' => 'Gasoline 98'],
            ['value' => 'Gasoline special 98'],
            ['value' => 'LPG'],
            ['value' => 'LNG'],
        ];

        DB::table('types')->insert($types);
    }
}
