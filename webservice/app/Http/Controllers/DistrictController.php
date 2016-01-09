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

namespace App\Http\Controllers;

class DistrictController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index()
    {
        $districts = app('db')->table('districts')->get([
                'id', 'value', 'updated_at',
            ]);

        return response()->json(['districts' => $districts], 200, [], JSON_NUMERIC_CHECK);
    }

    /**
     * Display the specified resource.
     *
     * @param int $id
     *
     * @return Response
     */
    public function show($id)
    {
        $district = app('db')->table('districts')->where('id', $id)->first([
                'id', 'value', 'updated_at',
            ]);

        return response()->json(['district' => $district], 200, [], JSON_NUMERIC_CHECK);
    }
}
