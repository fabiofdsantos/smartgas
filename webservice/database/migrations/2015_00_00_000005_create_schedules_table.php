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
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateSchedulesTable extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('schedules', function (Blueprint $table) {
            $table->increments('id');
            $table->dateTime('open_working_days')->nullable();
            $table->dateTime('close_working_days')->nullable();
            $table->dateTime('open_saturdays')->nullable();
            $table->dateTime('close_saturdays')->nullable();
            $table->dateTime('open_holidays')->nullable();
            $table->dateTime('close_holidays')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down()
    {
        Schema::dropIfExists('schedules');
    }
}
