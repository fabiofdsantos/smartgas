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

class BrandController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index()
    {
        $brands = app('db')->table('brands')->get(['id', 'value', 'updated_at']);

        foreach ($brands as $brand) {
            $data = file_get_contents(storage_path('app/brands/').$brand->id.'.jpg');
            $brand->image = base64_encode($data);
        }

        return response()->json(['brands' => $brands], 200, [], JSON_NUMERIC_CHECK);
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
        $brand = app('db')->table('brands')->where('id', $id)->first(['id', 'value', 'updated_at']);

        $data = file_get_contents(storage_path('app/brands/').$brand->id.'.jpg');
        $brand->image = 'data:image/jpg;base64,'.base64_encode($data);

        return response()->json(['brand' => $brand], 200, [], JSON_NUMERIC_CHECK);
    }
}
