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

class PricesTableSeeder extends Seeder
{
    public function run()
    {
        DB::table('prices')->delete();

        $pricesList[] = [
            'station_id' => app('db')->table('stations')->where('title', 'E.S. Leiria Sul')->pluck('id'),
            'type_id'    => app('db')->table('types')->where('value', 'Gasóleo simples')->pluck('id'),
            'value'      => '1.029',
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $pricesList[] = [
            'station_id' => app('db')->table('stations')->where('title', 'E.S. Leiria Sul')->pluck('id'),
            'type_id'    => app('db')->table('types')->where('value', 'Gasóleo especial')->pluck('id'),
            'value'      => '1.084',
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $pricesList[] = [
            'station_id' => app('db')->table('stations')->where('title', 'E.S. Leiria Sul')->pluck('id'),
            'type_id'    => app('db')->table('types')->where('value', 'Gasolina simples 95')->pluck('id'),
            'value'      => '1.304',
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $pricesList[] = [
            'station_id' => app('db')->table('stations')->where('title', 'Galp Leiria Continente')->pluck('id'),
            'type_id'    => app('db')->table('types')->where('value', 'Gasóleo simples')->pluck('id'),
            'value'      => '1.049',
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $pricesList[] = [
            'station_id' => app('db')->table('stations')->where('title', 'Galp Leiria Continente')->pluck('id'),
            'type_id'    => app('db')->table('types')->where('value', 'Gasóleo')->pluck('id'),
            'value'      => '1.069',
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $pricesList[] = [
            'station_id' => app('db')->table('stations')->where('title', 'Galp Leiria Continente')->pluck('id'),
            'type_id'    => app('db')->table('types')->where('value', 'Gasolina simples 95')->pluck('id'),
            'value'      => '1.324',
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $pricesList[] = [
            'station_id' => app('db')->table('stations')->where('title', 'BP Estrada da Estação')->pluck('id'),
            'type_id'    => app('db')->table('types')->where('value', 'Gasóleo simples')->pluck('id'),
            'value'      => '1.099',
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $pricesList[] = [
            'station_id' => app('db')->table('stations')->where('title', 'BP Estrada da Estação')->pluck('id'),
            'type_id'    => app('db')->table('types')->where('value', 'Gasóleo especial')->pluck('id'),
            'value'      => '1.199',
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $pricesList[] = [
            'station_id' => app('db')->table('stations')->where('title', 'BP Estrada da Estação')->pluck('id'),
            'type_id'    => app('db')->table('types')->where('value', 'Gasolina simples 95')->pluck('id'),
            'value'      => '1.379',
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $pricesList[] = [
            'station_id' => app('db')->table('stations')->where('title', 'BP Estrada da Estação')->pluck('id'),
            'type_id'    => app('db')->table('types')->where('value', 'Gasolina especial 98')->pluck('id'),
            'value'      => '1.539',
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $pricesList[] = [
            'station_id' => app('db')->table('stations')->where('title', 'PRIO Leiria')->pluck('id'),
            'type_id'    => app('db')->table('types')->where('value', 'Gasóleo simples')->pluck('id'),
            'value'      => '1.029',
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $pricesList[] = [
            'station_id' => app('db')->table('stations')->where('title', 'PRIO Leiria')->pluck('id'),
            'type_id'    => app('db')->table('types')->where('value', 'Gasóleo especial')->pluck('id'),
            'value'      => '0.999',
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $pricesList[] = [
            'station_id' => app('db')->table('stations')->where('title', 'PRIO Leiria')->pluck('id'),
            'type_id'    => app('db')->table('types')->where('value', 'Gasolina simples 95')->pluck('id'),
            'value'      => '1.309',
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $pricesList[] = [
            'station_id' => app('db')->table('stations')->where('title', 'PRIO Leiria')->pluck('id'),
            'type_id'    => app('db')->table('types')->where('value', 'Gasolina especial 95')->pluck('id'),
            'value'      => '1.279',
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $pricesList[] = [
            'station_id' => app('db')->table('stations')->where('title', 'LEIRIA POUSOS')->pluck('id'),
            'type_id'    => app('db')->table('types')->where('value', 'Gasóleo simples')->pluck('id'),
            'value'      => '1.029',
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $pricesList[] = [
            'station_id' => app('db')->table('stations')->where('title', 'LEIRIA POUSOS')->pluck('id'),
            'type_id'    => app('db')->table('types')->where('value', 'Gasóleo especial')->pluck('id'),
            'value'      => '1.059',
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $pricesList[] = [
            'station_id' => app('db')->table('stations')->where('title', 'LEIRIA POUSOS')->pluck('id'),
            'type_id'    => app('db')->table('types')->where('value', 'Gasolina simples 95')->pluck('id'),
            'value'      => '1.294',
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        $pricesList[] = [
            'station_id' => app('db')->table('stations')->where('title', 'LEIRIA POUSOS')->pluck('id'),
            'type_id'    => app('db')->table('types')->where('value', 'Gasolina especial 95')->pluck('id'),
            'value'      => '1.324',
            'created_at' => \Carbon\Carbon::now(),
            'updated_at' => \Carbon\Carbon::now(),
        ];

        foreach ($pricesList as $prices) {
            DB::table('prices')->insert($prices);
        }
    }
}
