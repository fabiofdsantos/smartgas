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

        $stations[] = [
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

        $stations[] = [
            'title'           => 'Galp Leiria Continente',
            'address'         => 'EN 1 2400-823 Parceiros-Alto de Vieiro',
            'latitude'        => '39.730700',
            'longitude'       => '-8.824482',
            'brand_id'        => app('db')->table('brands')->where('value', 'Galp')->pluck('id'),
            'schedule_id'     => null,
            'district_id'     => app('db')->table('districts')->where('value', 'Leiria')->pluck('id'),
            'municipality_id' => app('db')->table('municipalities')->where('value', 'Leiria')->pluck('id'),
            'created_at'      => \Carbon\Carbon::now(),
            'updated_at'      => \Carbon\Carbon::now(),
        ];

        $stations[] = [
            'title'           => 'BP Estrada da Estação',
            'address'         => 'Estrada da Estacao 2400-281 Leiria',
            'latitude'        => '39.754264',
            'longitude'       => '-8.812783',
            'brand_id'        => app('db')->table('brands')->where('value', 'BP')->pluck('id'),
            'schedule_id'     => null,
            'district_id'     => app('db')->table('districts')->where('value', 'Leiria')->pluck('id'),
            'municipality_id' => app('db')->table('municipalities')->where('value', 'Leiria')->pluck('id'),
            'created_at'      => \Carbon\Carbon::now(),
            'updated_at'      => \Carbon\Carbon::now(),
        ];

        $stations[] = [
            'title'           => 'PRIO Leiria',
            'address'         => 'Rua Capitão Mouzinho Albuquerque nº 70 2400-193 Leiria',
            'latitude'        => '39.747570',
            'longitude'       => '-8.805151',
            'brand_id'        => app('db')->table('brands')->where('value', 'PRIO')->pluck('id'),
            'schedule_id'     => null,
            'district_id'     => app('db')->table('districts')->where('value', 'Leiria')->pluck('id'),
            'municipality_id' => app('db')->table('municipalities')->where('value', 'Leiria')->pluck('id'),
            'created_at'      => \Carbon\Carbon::now(),
            'updated_at'      => \Carbon\Carbon::now(),
        ];

        $stations[] = [
            'title'           => 'LEIRIA POUSOS',
            'address'         => 'R. Carolina Ferreira Ribeiro - Pousos 2400-092 Leiria',
            'latitude'        => '39.741122',
            'longitude'       => '-8.799587',
            'brand_id'        => app('db')->table('brands')->where('value', 'CEPSA')->pluck('id'),
            'schedule_id'     => null,
            'district_id'     => app('db')->table('districts')->where('value', 'Leiria')->pluck('id'),
            'municipality_id' => app('db')->table('municipalities')->where('value', 'Leiria')->pluck('id'),
            'created_at'      => \Carbon\Carbon::now(),
            'updated_at'      => \Carbon\Carbon::now(),
        ];

        foreach ($stations as $station) {
            DB::table('stations')->insert($station);
        }
    }
}
