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
        $brands = app('db')->table('brands')->get();

        return response()->json(['brands' => $brands], 200);
    }
}
