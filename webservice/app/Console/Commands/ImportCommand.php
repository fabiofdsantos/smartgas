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

namespace App\Console\Commands;

use Illuminate\Console\Command;

class ImportCommand extends Command
{
    const WSDL = 'http://www.precoscombustiveis.dgeg.pt/PCOM/Recebe.wsdl';

    /**
     * The console command name.
     *
     * @var string
     */
    protected $name = 'import';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Import data from an external WebService.';

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
    }
}
