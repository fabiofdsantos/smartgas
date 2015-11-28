<?php

/*
 * This file is part of SmartGas.
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
            ['value' => 'Gasóleo simples'],
            ['value' => 'Gasóleo'],
            ['value' => 'Gasóleo especial'],
            ['value' => 'Gasóleo colorido'],
            ['value' => 'Gasolina simples 95'],
            ['value' => 'Gasolina 95'],
            ['value' => 'Gasolina especial 95'],
            ['value' => 'Gasolina 98'],
            ['value' => 'Gasolina especial 98'],
            ['value' => 'GPL'],
            ['value' => 'GNC'],
            ['value' => 'GNL'],
        ];

        DB::table('types')->insert($types);
    }
}
