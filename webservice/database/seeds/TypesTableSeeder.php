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

        $types[] = [
            'value' => 'Gasóleo',
            'parent_id' => null,
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $types[] = [
            'value' => 'Gasóleo simples',
            'parent_id' => app('db')->table('types')->where('value', 'Gasóleo')->pluck('id'),
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $types[] = [
            'value' => 'Gasóleo especial',
            'parent_id' => app('db')->table('types')->where('value', 'Gasóleo')->pluck('id'),
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $types[] = [
            'value' => 'Gasóleo colorido',
            'parent_id' => app('db')->table('types')->where('value', 'Gasóleo')->pluck('id'),
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $types[] = [
            'value' => 'Gasolina 95',
            'parent_id' => null,
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $types[] = [
            'value' => 'Gasolina simples 95',
            'parent_id' => app('db')->table('types')->where('value', 'Gasolina 95')->pluck('id'),
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $types[] = [
            'value' => 'Gasolina especial 95',
            'parent_id' => app('db')->table('types')->where('value', 'Gasolina 95')->pluck('id'),
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $types[] = [
            'value' => 'Gasolina 98',
            'parent_id' => null,
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $types[] = [
            'value' => 'Gasolina especial 98',
            'parent_id' => app('db')->table('types')->where('value', 'Gasolina 98')->pluck('id'),
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $types[] = [
            'value' => 'LPG',
            'parent_id' => null,
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $tyoes[] = [
            'value' => 'LNG',
            'parent_id' => null,
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        DB::table('types')->insert($types);
    }
}
