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

use Illuminate\Http\Request;

class StationController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @param Request $request
     *
     * @return Response
     */
    public function index(Request $request)
    {
        $stations = app('db')->table('stations')
            ->where(function ($query) use ($request) {

                if (!empty($request->input('district'))) {
                    $query->where('district_id', $request->input('district'));
                }

                if (!empty($request->input('municipality'))) {
                    $query->where('municipality_id', $request->input('municipality'));
                }

                if (!empty($request->input('brand'))) {
                    $query->whereIn('brand_id', explode(',', $request->input('brand')));
                }
            })->get([
                    'id', 'title', 'address', 'latitude', 'longitude',
                    'brand_id', 'schedule_id', 'district_id', 'municipality_id',
                    'updated_at',
                ]);

        return response()->json(['stations' => $stations], 200, [], JSON_NUMERIC_CHECK);
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
        $station = app('db')->table('stations')->where('id', $id)->first([
                'id', 'title', 'address', 'latitude', 'longitude', 'brand_id',
                'schedule_id', 'district_id', 'municipality_id', 'updated_at',
            ]);

        return response()->json(['station' => $station], 200, [], JSON_NUMERIC_CHECK);
    }
}
