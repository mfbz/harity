// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract HarityFactory {
    // The byte array where each emoji is 4 consecutive byte
    bytes internal constant EMOJI_DICTIONARY =
        "\xF0\x9F\x8E\x83\xF0\x9F\x8E\x84\xF0\x9F\x8E\x86\xF0\x9F\x8E\x87\xF0\x9F\xA7\xA8\xF0\x9F\x8E\x88\xF0\x9F\x8E\x89\xF0\x9F\x8E\x8A\xF0\x9F\x8E\x8B\xF0\x9F\x8E\x8D\xF0\x9F\x8E\x8E\xF0\x9F\x8E\x8F\xF0\x9F\x8E\x90\xF0\x9F\x8E\x91\xF0\x9F\xA7\xA7\xF0\x9F\x8E\x80\xF0\x9F\x8E\x81\xF0\x9F\x8E\xAB\xF0\x9F\x8F\x86\xF0\x9F\x8F\x85\xF0\x9F\xA5\x87\xF0\x9F\xA5\x88\xF0\x9F\xA5\x89\xF0\x9F\xA5\x8E\xF0\x9F\x8F\x80\xF0\x9F\x8F\x90\xF0\x9F\x8F\x88\xF0\x9F\x8F\x89\xF0\x9F\x8E\xBE\xF0\x9F\xA5\x8F\xF0\x9F\x8E\xB3\xF0\x9F\x8F\x8F\xF0\x9F\x8F\x91\xF0\x9F\x8F\x92\xF0\x9F\xA5\x8D\xF0\x9F\x8F\x93\xF0\x9F\x8F\xB8\xF0\x9F\xA5\x8A\xF0\x9F\xA5\x8B\xF0\x9F\xA5\x85\xF0\x9F\x8E\xA3\xF0\x9F\xA4\xBF\xF0\x9F\x8E\xBD\xF0\x9F\x8E\xBF\xF0\x9F\x9B\xB7\xF0\x9F\xA5\x8C\xF0\x9F\x8E\xAF\xF0\x9F\xAA\x80\xF0\x9F\xAA\x81\xF0\x9F\x8E\xB1\xF0\x9F\x94\xAE\xF0\x9F\xAA\x84\xF0\x9F\xA7\xBF\xF0\x9F\x8E\xAE\xF0\x9F\x8E\xB0\xF0\x9F\x8E\xB2\xF0\x9F\xA7\xA9\xF0\x9F\xA7\xB8\xF0\x9F\xAA\x85\xF0\x9F\xAA\x86\xF0\x9F\x83\x8F\xF0\x9F\x80\x84\xF0\x9F\x8E\xB4\xF0\x9F\x8E\xAD\xF0\x9F\x8E\xA8\xF0\x9F\xA7\xB5\xF0\x9F\xAA\xA1\xF0\x9F\xA7\xB6\xF0\x9F\xAA\xA2\xF0\x9F\x90\xB5\xF0\x9F\x90\x92\xF0\x9F\xA6\x8D\xF0\x9F\xA6\xA7\xF0\x9F\x90\xB6\xF0\x9F\x90\x95\xF0\x9F\xA6\xAE\xF0\x9F\x90\xA9\xF0\x9F\x90\xBA\xF0\x9F\xA6\x8A\xF0\x9F\xA6\x9D\xF0\x9F\x90\xB1\xF0\x9F\x90\x88\xF0\x9F\xA6\x81\xF0\x9F\x90\xAF\xF0\x9F\x90\x85\xF0\x9F\x90\x86\xF0\x9F\x90\xB4\xF0\x9F\x90\x8E\xF0\x9F\xA6\x84\xF0\x9F\xA6\x93\xF0\x9F\xA6\x8C\xF0\x9F\xA6\xAC\xF0\x9F\x90\xAE\xF0\x9F\x90\x82\xF0\x9F\x90\x83\xF0\x9F\x90\x84\xF0\x9F\x90\xB7\xF0\x9F\x90\x96\xF0\x9F\x90\x97\xF0\x9F\x90\xBD\xF0\x9F\x90\x8F\xF0\x9F\x90\x91\xF0\x9F\x90\x90\xF0\x9F\x90\xAA\xF0\x9F\x90\xAB\xF0\x9F\xA6\x99\xF0\x9F\xA6\x92\xF0\x9F\x90\x98\xF0\x9F\xA6\xA3\xF0\x9F\xA6\x8F\xF0\x9F\xA6\x9B\xF0\x9F\x90\xAD\xF0\x9F\x90\x81\xF0\x9F\x90\x80\xF0\x9F\x90\xB9\xF0\x9F\x90\xB0\xF0\x9F\x90\x87\xF0\x9F\xA6\xAB\xF0\x9F\xA6\x94\xF0\x9F\xA6\x87\xF0\x9F\x90\xBB\xF0\x9F\x90\xA8\xF0\x9F\x90\xBC\xF0\x9F\xA6\xA5\xF0\x9F\xA6\xA6\xF0\x9F\xA6\xA8\xF0\x9F\xA6\x98\xF0\x9F\xA6\xA1\xF0\x9F\x90\xBE\xF0\x9F\xA6\x83\xF0\x9F\x90\x94\xF0\x9F\x90\x93\xF0\x9F\x90\xA3\xF0\x9F\x90\xA4\xF0\x9F\x90\xA5\xF0\x9F\x90\xA6\xF0\x9F\x90\xA7\xF0\x9F\xA6\x85\xF0\x9F\xA6\x86\xF0\x9F\xA6\xA2\xF0\x9F\xA6\x89\xF0\x9F\xA6\xA4\xF0\x9F\xAA\xB6\xF0\x9F\xA6\xA9\xF0\x9F\xA6\x9A\xF0\x9F\xA6\x9C\xF0\x9F\x90\xB8\xF0\x9F\x90\x8A\xF0\x9F\x90\xA2\xF0\x9F\xA6\x8E\xF0\x9F\x90\x8D\xF0\x9F\x90\xB2\xF0\x9F\x90\x89\xF0\x9F\xA6\x95\xF0\x9F\xA6\x96\xF0\x9F\x90\xB3\xF0\x9F\x90\x8B\xF0\x9F\x90\xAC\xF0\x9F\xA6\xAD\xF0\x9F\x90\x9F\xF0\x9F\x90\xA0\xF0\x9F\x90\xA1\xF0\x9F\xA6\x88\xF0\x9F\x90\x99\xF0\x9F\x90\x9A\xF0\x9F\x90\x8C\xF0\x9F\xA6\x8B\xF0\x9F\x90\x9B\xF0\x9F\x90\x9C\xF0\x9F\x90\x9D\xF0\x9F\xAA\xB2\xF0\x9F\x90\x9E\xF0\x9F\xA6\x97\xF0\x9F\xAA\xB3\xF0\x9F\xA6\x82\xF0\x9F\xA6\x9F\xF0\x9F\xAA\xB0\xF0\x9F\xAA\xB1\xF0\x9F\xA6\xA0\xF0\x9F\x92\x90\xF0\x9F\x8C\xB8\xF0\x9F\x92\xAE\xF0\x9F\x8C\xB9\xF0\x9F\xA5\x80\xF0\x9F\x8C\xBA\xF0\x9F\x8C\xBB\xF0\x9F\x8C\xBC\xF0\x9F\x8C\xB7\xF0\x9F\x8C\xB1\xF0\x9F\xAA\xB4\xF0\x9F\x8C\xB2\xF0\x9F\x8C\xB3\xF0\x9F\x8C\xB4\xF0\x9F\x8C\xB5\xF0\x9F\x8C\xBE\xF0\x9F\x8C\xBF\xF0\x9F\x8D\x80\xF0\x9F\x8D\x81\xF0\x9F\x8D\x82\xF0\x9F\x8D\x83\xF0\x9F\x8D\x87\xF0\x9F\x8D\x88\xF0\x9F\x8D\x89\xF0\x9F\x8D\x8A\xF0\x9F\x8D\x8B\xF0\x9F\x8D\x8C\xF0\x9F\x8D\x8D\xF0\x9F\xA5\xAD\xF0\x9F\x8D\x8E\xF0\x9F\x8D\x8F\xF0\x9F\x8D\x90\xF0\x9F\x8D\x91\xF0\x9F\x8D\x92\xF0\x9F\x8D\x93\xF0\x9F\xAB\x90\xF0\x9F\xA5\x9D\xF0\x9F\x8D\x85\xF0\x9F\xAB\x92\xF0\x9F\xA5\xA5\xF0\x9F\xA5\x91\xF0\x9F\x8D\x86\xF0\x9F\xA5\x94\xF0\x9F\xA5\x95\xF0\x9F\x8C\xBD\xF0\x9F\xAB\x91\xF0\x9F\xA5\x92\xF0\x9F\xA5\xAC\xF0\x9F\xA5\xA6\xF0\x9F\xA7\x84\xF0\x9F\xA7\x85\xF0\x9F\x8D\x84\xF0\x9F\xA5\x9C\xF0\x9F\x8C\xB0\xF0\x9F\x8D\x9E\xF0\x9F\xA5\x90\xF0\x9F\xA5\x96\xF0\x9F\xAB\x93\xF0\x9F\xA5\xA8\xF0\x9F\xA5\xAF\xF0\x9F\xA5\x9E\xF0\x9F\xA7\x87\xF0\x9F\xA7\x80\xF0\x9F\x8D\x96\xF0\x9F\x8D\x97\xF0\x9F\xA5\xA9\xF0\x9F\xA5\x93\xF0\x9F\x8D\x94\xF0\x9F\x8D\x9F\xF0\x9F\x8D\x95\xF0\x9F\x8C\xAD\xF0\x9F\xA5\xAA\xF0\x9F\x8C\xAE\xF0\x9F\x8C\xAF\xF0\x9F\xAB\x94\xF0\x9F\xA5\x99\xF0\x9F\xA7\x86\xF0\x9F\xA5\x9A\xF0\x9F\x8D\xB3\xF0\x9F\xA5\x98\xF0\x9F\x8D\xB2\xF0\x9F\xAB\x95\xF0\x9F\xA5\xA3\xF0\x9F\xA5\x97\xF0\x9F\x8D\xBF\xF0\x9F\xA7\x88\xF0\x9F\xA7\x82\xF0\x9F\xA5\xAB\xF0\x9F\x8D\xB1\xF0\x9F\x8D\x98\xF0\x9F\x8D\x99\xF0\x9F\x8D\x9A\xF0\x9F\x8D\x9B\xF0\x9F\x8D\x9C\xF0\x9F\x8D\x9D\xF0\x9F\x8D\xA0\xF0\x9F\x8D\xA2\xF0\x9F\x8D\xA3\xF0\x9F\x8D\xA4\xF0\x9F\x8D\xA5\xF0\x9F\xA5\xAE\xF0\x9F\x8D\xA1\xF0\x9F\xA5\x9F\xF0\x9F\xA5\xA0\xF0\x9F\xA5\xA1\xF0\x9F\xA6\x80\xF0\x9F\xA6\x9E\xF0\x9F\xA6\x90\xF0\x9F\xA6\x91\xF0\x9F\xA6\xAA\xF0\x9F\x8D\xA6\xF0\x9F\x8D\xA7\xF0\x9F\x8D\xA8\xF0\x9F\x8D\xA9\xF0\x9F\x8D\xAA\xF0\x9F\x8E\x82\xF0\x9F\x8D\xB0\xF0\x9F\xA7\x81\xF0\x9F\xA5\xA7\xF0\x9F\x8D\xAB\xF0\x9F\x8D\xAC\xF0\x9F\x8D\xAD\xF0\x9F\x8D\xAE\xF0\x9F\x8D\xAF\xF0\x9F\x8D\xBC\xF0\x9F\xA5\x9B\xF0\x9F\xAB\x96\xF0\x9F\x8D\xB5\xF0\x9F\x8D\xB6\xF0\x9F\x8D\xBE\xF0\x9F\x8D\xB7\xF0\x9F\x8D\xB8\xF0\x9F\x8D\xB9\xF0\x9F\x8D\xBA\xF0\x9F\x8D\xBB\xF0\x9F\xA5\x82\xF0\x9F\xA5\x83\xF0\x9F\xA5\xA4\xF0\x9F\xA7\x8B\xF0\x9F\xA7\x83\xF0\x9F\xA7\x89\xF0\x9F\xA7\x8A\xF0\x9F\xA5\xA2\xF0\x9F\x8D\xB4\xF0\x9F\xA5\x84\xF0\x9F\x94\xAA\xF0\x9F\x8F\xBA\xF0\x9F\x91\x93\xF0\x9F\xA5\xBD\xF0\x9F\xA5\xBC\xF0\x9F\xA6\xBA\xF0\x9F\x91\x94\xF0\x9F\x91\x95\xF0\x9F\x91\x96\xF0\x9F\xA7\xA3\xF0\x9F\xA7\xA4\xF0\x9F\xA7\xA5\xF0\x9F\xA7\xA6\xF0\x9F\x91\x97\xF0\x9F\x91\x98\xF0\x9F\xA5\xBB\xF0\x9F\xA9\xB1\xF0\x9F\xA9\xB2\xF0\x9F\xA9\xB3\xF0\x9F\x91\x99\xF0\x9F\x91\x9A\xF0\x9F\x91\x9B\xF0\x9F\x91\x9C\xF0\x9F\x91\x9D\xF0\x9F\x8E\x92\xF0\x9F\xA9\xB4\xF0\x9F\x91\x9E\xF0\x9F\x91\x9F\xF0\x9F\xA5\xBE\xF0\x9F\xA5\xBF\xF0\x9F\x91\xA0\xF0\x9F\x91\xA1\xF0\x9F\xA9\xB0\xF0\x9F\x91\xA2\xF0\x9F\x91\x91\xF0\x9F\x91\x92\xF0\x9F\x8E\xA9\xF0\x9F\x8E\x93\xF0\x9F\xA7\xA2\xF0\x9F\xAA\x96\xF0\x9F\x93\xBF\xF0\x9F\x92\x84\xF0\x9F\x92\x8D\xF0\x9F\x92\x8E\xF0\x9F\x94\x87\xF0\x9F\x94\x88\xF0\x9F\x94\x89\xF0\x9F\x94\x8A\xF0\x9F\x93\xA2\xF0\x9F\x93\xA3\xF0\x9F\x93\xAF\xF0\x9F\x94\x94\xF0\x9F\x94\x95\xF0\x9F\x8E\xBC\xF0\x9F\x8E\xB5\xF0\x9F\x8E\xB6\xF0\x9F\x8E\xA4\xF0\x9F\x8E\xA7\xF0\x9F\x93\xBB\xF0\x9F\x8E\xB7\xF0\x9F\xAA\x97\xF0\x9F\x8E\xB8\xF0\x9F\x8E\xB9\xF0\x9F\x8E\xBA\xF0\x9F\x8E\xBB\xF0\x9F\xAA\x95\xF0\x9F\xA5\x81\xF0\x9F\xAA\x98\xF0\x9F\x93\xB1\xF0\x9F\x93\xB2\xF0\x9F\x93\x9E\xF0\x9F\x93\x9F\xF0\x9F\x93\xA0\xF0\x9F\x94\x8B\xF0\x9F\x94\x8C\xF0\x9F\x92\xBB\xF0\x9F\x92\xBD\xF0\x9F\x92\xBE\xF0\x9F\x92\xBF\xF0\x9F\x93\x80\xF0\x9F\xA7\xAE\xF0\x9F\x8E\xA5\xF0\x9F\x8E\xAC\xF0\x9F\x93\xBA\xF0\x9F\x93\xB7\xF0\x9F\x93\xB8\xF0\x9F\x93\xB9\xF0\x9F\x93\xBC\xF0\x9F\x94\x8D\xF0\x9F\x94\x8E\xF0\x9F\x92\xA1\xF0\x9F\x94\xA6\xF0\x9F\x8F\xAE\xF0\x9F\xAA\x94\xF0\x9F\x93\x94\xF0\x9F\x93\x95\xF0\x9F\x93\x96\xF0\x9F\x93\x97\xF0\x9F\x93\x98\xF0\x9F\x93\x99\xF0\x9F\x93\x9A\xF0\x9F\x93\x93\xF0\x9F\x93\x92\xF0\x9F\x93\x83\xF0\x9F\x93\x9C\xF0\x9F\x93\x84\xF0\x9F\x93\xB0\xF0\x9F\x93\x91\xF0\x9F\x94\x96\xF0\x9F\x92\xB0\xF0\x9F\xAA\x99\xF0\x9F\x92\xB4\xF0\x9F\x92\xB5\xF0\x9F\x92\xB6\xF0\x9F\x92\xB7\xF0\x9F\x92\xB8\xF0\x9F\x92\xB3\xF0\x9F\xA7\xBE\xF0\x9F\x92\xB9\xF0\x9F\x93\xA7\xF0\x9F\x93\xA8\xF0\x9F\x93\xA9\xF0\x9F\x93\xA4\xF0\x9F\x93\xA5\xF0\x9F\x93\xA6\xF0\x9F\x93\xAB\xF0\x9F\x93\xAA\xF0\x9F\x93\xAC\xF0\x9F\x93\xAD\xF0\x9F\x93\xAE\xF0\x9F\x93\x9D\xF0\x9F\x92\xBC\xF0\x9F\x93\x81\xF0\x9F\x93\x82\xF0\x9F\x93\x85\xF0\x9F\x93\x86\xF0\x9F\x93\x87\xF0\x9F\x93\x88\xF0\x9F\x93\x89\xF0\x9F\x93\x8A\xF0\x9F\x93\x8B\xF0\x9F\x93\x8C\xF0\x9F\x93\x8D\xF0\x9F\x93\x8E\xF0\x9F\x93\x8F\xF0\x9F\x93\x90\xF0\x9F\x94\x92\xF0\x9F\x94\x93\xF0\x9F\x94\x8F\xF0\x9F\x94\x90\xF0\x9F\x94\x91\xF0\x9F\x94\xA8\xF0\x9F\xAA\x93\xF0\x9F\x94\xAB\xF0\x9F\xAA\x83\xF0\x9F\x8F\xB9\xF0\x9F\xAA\x9A\xF0\x9F\x94\xA7\xF0\x9F\xAA\x9B\xF0\x9F\x94\xA9\xF0\x9F\xA6\xAF\xF0\x9F\x94\x97\xF0\x9F\xAA\x9D\xF0\x9F\xA7\xB0\xF0\x9F\xA7\xB2\xF0\x9F\xAA\x9C\xF0\x9F\xA7\xAA\xF0\x9F\xA7\xAB\xF0\x9F\xA7\xAC\xF0\x9F\x94\xAC\xF0\x9F\x94\xAD\xF0\x9F\x93\xA1\xF0\x9F\x92\x89\xF0\x9F\xA9\xB8\xF0\x9F\x92\x8A\xF0\x9F\xA9\xB9\xF0\x9F\xA9\xBA\xF0\x9F\x9A\xAA\xF0\x9F\x9B\x97\xF0\x9F\xAA\x9E\xF0\x9F\xAA\x9F\xF0\x9F\xAA\x91\xF0\x9F\x9A\xBD\xF0\x9F\xAA\xA0\xF0\x9F\x9A\xBF\xF0\x9F\x9B\x81\xF0\x9F\xAA\xA4\xF0\x9F\xAA\x92\xF0\x9F\xA7\xB4\xF0\x9F\xA7\xB7\xF0\x9F\xA7\xB9\xF0\x9F\xA7\xBA\xF0\x9F\xA7\xBB\xF0\x9F\xAA\xA3\xF0\x9F\xA7\xBC\xF0\x9F\xAA\xA5\xF0\x9F\xA7\xBD\xF0\x9F\xA7\xAF\xF0\x9F\x9B\x92\xF0\x9F\x9A\xAC\xF0\x9F\xAA\xA6\xF0\x9F\x97\xBF\xF0\x9F\xAA\xA7\xF0\x9F\x91\x8B\xF0\x9F\xA4\x9A\xF0\x9F\x96\x96\xF0\x9F\x91\x8C\xF0\x9F\xA4\x8C\xF0\x9F\xA4\x8F\xF0\x9F\xA4\x9E\xF0\x9F\xA4\x9F\xF0\x9F\xA4\x98\xF0\x9F\xA4\x99\xF0\x9F\x91\x88\xF0\x9F\x91\x89\xF0\x9F\x91\x86\xF0\x9F\x96\x95\xF0\x9F\x91\x87\xF0\x9F\x91\x8D\xF0\x9F\x91\x8E\xF0\x9F\x91\x8A\xF0\x9F\xA4\x9B\xF0\x9F\xA4\x9C\xF0\x9F\x91\x8F\xF0\x9F\x99\x8C\xF0\x9F\x91\x90\xF0\x9F\xA4\xB2\xF0\x9F\xA4\x9D\xF0\x9F\x99\x8F\xF0\x9F\x92\x85\xF0\x9F\xA4\xB3\xF0\x9F\x92\xAA\xF0\x9F\xA6\xBE\xF0\x9F\xA6\xBF\xF0\x9F\xA6\xB5\xF0\x9F\xA6\xB6\xF0\x9F\x91\x82\xF0\x9F\xA6\xBB\xF0\x9F\x91\x83\xF0\x9F\xA7\xA0\xF0\x9F\xAB\x80\xF0\x9F\xAB\x81\xF0\x9F\xA6\xB7\xF0\x9F\xA6\xB4\xF0\x9F\x91\x80\xF0\x9F\x91\x85\xF0\x9F\x91\x84\xF0\x9F\x91\xB6\xF0\x9F\xA7\x92\xF0\x9F\x91\xA6\xF0\x9F\x91\xA7\xF0\x9F\xA7\x91\xF0\x9F\x91\xB1\xF0\x9F\x91\xA8\xF0\x9F\xA7\x94\xF0\x9F\x91\xA9\xF0\x9F\xA7\x93\xF0\x9F\x91\xB4\xF0\x9F\x91\xB5\xF0\x9F\x99\x8D\xF0\x9F\x99\x8E\xF0\x9F\x99\x85\xF0\x9F\x99\x86\xF0\x9F\x92\x81\xF0\x9F\x99\x8B\xF0\x9F\xA7\x8F\xF0\x9F\x99\x87\xF0\x9F\xA4\xA6\xF0\x9F\xA4\xB7\xF0\x9F\x91\xAE\xF0\x9F\x92\x82\xF0\x9F\xA5\xB7\xF0\x9F\x91\xB7\xF0\x9F\xA4\xB4\xF0\x9F\x91\xB8\xF0\x9F\x91\xB3\xF0\x9F\x91\xB2\xF0\x9F\xA7\x95\xF0\x9F\xA4\xB5\xF0\x9F\x91\xB0\xF0\x9F\xA4\xB0\xF0\x9F\xA4\xB1\xF0\x9F\x91\xBC\xF0\x9F\x8E\x85\xF0\x9F\xA4\xB6\xF0\x9F\xA6\xB8\xF0\x9F\xA6\xB9\xF0\x9F\xA7\x99\xF0\x9F\xA7\x9A\xF0\x9F\xA7\x9B\xF0\x9F\xA7\x9C\xF0\x9F\xA7\x9D\xF0\x9F\xA7\x9E\xF0\x9F\xA7\x9F\xF0\x9F\x92\x86\xF0\x9F\x92\x87\xF0\x9F\x9A\xB6\xF0\x9F\xA7\x8D\xF0\x9F\xA7\x8E\xF0\x9F\x8F\x83\xF0\x9F\x92\x83\xF0\x9F\x95\xBA\xF0\x9F\x91\xAF\xF0\x9F\xA7\x96\xF0\x9F\xA7\x97\xF0\x9F\xA4\xBA\xF0\x9F\x8F\x87\xF0\x9F\x8F\x82\xF0\x9F\x8F\x84\xF0\x9F\x9A\xA3\xF0\x9F\x8F\x8A\xF0\x9F\x9A\xB4\xF0\x9F\x9A\xB5\xF0\x9F\xA4\xB8\xF0\x9F\xA4\xBC\xF0\x9F\xA4\xBD\xF0\x9F\xA4\xBE\xF0\x9F\xA4\xB9\xF0\x9F\xA7\x98\xF0\x9F\x9B\x80\xF0\x9F\x9B\x8C\xF0\x9F\x91\xAD\xF0\x9F\x91\xAB\xF0\x9F\x91\xAC\xF0\x9F\x92\x8F\xF0\x9F\x92\x91\xF0\x9F\x91\xAA\xF0\x9F\x91\xA4\xF0\x9F\x91\xA5\xF0\x9F\xAB\x82\xF0\x9F\x91\xA3\xF0\x9F\x98\x80\xF0\x9F\x98\x83\xF0\x9F\x98\x84\xF0\x9F\x98\x81\xF0\x9F\x98\x86\xF0\x9F\x98\x85\xF0\x9F\xA4\xA3\xF0\x9F\x98\x82\xF0\x9F\x99\x82\xF0\x9F\x99\x83\xF0\x9F\x98\x89\xF0\x9F\x98\x8A\xF0\x9F\x98\x87\xF0\x9F\xA5\xB0\xF0\x9F\x98\x8D\xF0\x9F\xA4\xA9\xF0\x9F\x98\x98\xF0\x9F\x98\x97\xF0\x9F\x98\x9A\xF0\x9F\x98\x99\xF0\x9F\xA5\xB2\xF0\x9F\x98\x8B\xF0\x9F\x98\x9B\xF0\x9F\x98\x9C\xF0\x9F\xA4\xAA\xF0\x9F\x98\x9D\xF0\x9F\xA4\x91\xF0\x9F\xA4\x97\xF0\x9F\xA4\xAD\xF0\x9F\xA4\xAB\xF0\x9F\xA4\x94\xF0\x9F\xA4\x90\xF0\x9F\xA4\xA8\xF0\x9F\x98\x90\xF0\x9F\x98\x91\xF0\x9F\x98\xB6\xF0\x9F\x98\x8F\xF0\x9F\x98\x92\xF0\x9F\x99\x84\xF0\x9F\x98\xAC\xF0\x9F\xA4\xA5\xF0\x9F\x98\x8C\xF0\x9F\x98\x94\xF0\x9F\x98\xAA\xF0\x9F\xA4\xA4\xF0\x9F\x98\xB4\xF0\x9F\x98\xB7\xF0\x9F\xA4\x92\xF0\x9F\xA4\x95\xF0\x9F\xA4\xA2\xF0\x9F\xA4\xAE\xF0\x9F\xA4\xA7\xF0\x9F\xA5\xB5\xF0\x9F\xA5\xB6\xF0\x9F\xA5\xB4\xF0\x9F\x98\xB5\xF0\x9F\xA4\xAF\xF0\x9F\xA4\xA0\xF0\x9F\xA5\xB3\xF0\x9F\xA5\xB8\xF0\x9F\x98\x8E\xF0\x9F\xA4\x93\xF0\x9F\xA7\x90\xF0\x9F\x98\x95\xF0\x9F\x98\x9F\xF0\x9F\x99\x81\xF0\x9F\x98\xAE\xF0\x9F\x98\xAF\xF0\x9F\x98\xB2\xF0\x9F\x98\xB3\xF0\x9F\xA5\xBA\xF0\x9F\x98\xA6\xF0\x9F\x98\xA7\xF0\x9F\x98\xA8\xF0\x9F\x98\xB0\xF0\x9F\x98\xA5\xF0\x9F\x98\xA2\xF0\x9F\x98\xAD\xF0\x9F\x98\xB1\xF0\x9F\x98\x96\xF0\x9F\x98\xA3\xF0\x9F\x98\x9E\xF0\x9F\x98\x93\xF0\x9F\x98\xA9\xF0\x9F\x98\xAB\xF0\x9F\xA5\xB1\xF0\x9F\x98\xA4\xF0\x9F\x98\xA1\xF0\x9F\x98\xA0\xF0\x9F\xA4\xAC\xF0\x9F\x98\x88\xF0\x9F\x91\xBF\xF0\x9F\x92\x80\xF0\x9F\x92\xA9\xF0\x9F\xA4\xA1\xF0\x9F\x91\xB9\xF0\x9F\x91\xBA\xF0\x9F\x91\xBB\xF0\x9F\x91\xBD\xF0\x9F\x91\xBE\xF0\x9F\xA4\x96\xF0\x9F\x98\xBA\xF0\x9F\x98\xB8\xF0\x9F\x98\xB9\xF0\x9F\x98\xBB\xF0\x9F\x98\xBC\xF0\x9F\x98\xBD\xF0\x9F\x99\x80\xF0\x9F\x98\xBF\xF0\x9F\x98\xBE\xF0\x9F\x99\x88\xF0\x9F\x99\x89\xF0\x9F\x99\x8A\xF0\x9F\x92\x8B\xF0\x9F\x92\x8C\xF0\x9F\x92\x98\xF0\x9F\x92\x9D\xF0\x9F\x92\x96\xF0\x9F\x92\x97\xF0\x9F\x92\x93\xF0\x9F\x92\x9E\xF0\x9F\x92\x95\xF0\x9F\x92\x9F\xF0\x9F\x92\x94\xF0\x9F\xA7\xA1\xF0\x9F\x92\x9B\xF0\x9F\x92\x9A\xF0\x9F\x92\x99\xF0\x9F\x92\x9C\xF0\x9F\xA4\x8E\xF0\x9F\x96\xA4\xF0\x9F\xA4\x8D\xF0\x9F\x92\xAF\xF0\x9F\x92\xA2\xF0\x9F\x92\xA5\xF0\x9F\x92\xAB\xF0\x9F\x92\xA6\xF0\x9F\x92\xA8\xF0\x9F\x92\xA3\xF0\x9F\x92\xAC\xF0\x9F\x92\xAD\xF0\x9F\x92\xA4\xF0\x9F\x8C\x8D\xF0\x9F\x8C\x8E\xF0\x9F\x8C\x8F\xF0\x9F\x8C\x90\xF0\x9F\x97\xBE\xF0\x9F\xA7\xAD\xF0\x9F\x8C\x8B\xF0\x9F\x97\xBB\xF0\x9F\xA7\xB1\xF0\x9F\xAA\xA8\xF0\x9F\xAA\xB5\xF0\x9F\x9B\x96\xF0\x9F\x8F\xA0\xF0\x9F\x8F\xA1\xF0\x9F\x8F\xA2\xF0\x9F\x8F\xA3\xF0\x9F\x8F\xA4\xF0\x9F\x8F\xA5\xF0\x9F\x8F\xA6\xF0\x9F\x8F\xA8\xF0\x9F\x8F\xA9\xF0\x9F\x8F\xAA\xF0\x9F\x8F\xAB\xF0\x9F\x8F\xAC\xF0\x9F\x8F\xAD\xF0\x9F\x8F\xAF\xF0\x9F\x8F\xB0\xF0\x9F\x92\x92\xF0\x9F\x97\xBC\xF0\x9F\x97\xBD\xF0\x9F\x95\x8C\xF0\x9F\x9B\x95\xF0\x9F\x95\x8D\xF0\x9F\x95\x8B\xF0\x9F\x8C\x81\xF0\x9F\x8C\x83\xF0\x9F\x8C\x84\xF0\x9F\x8C\x85\xF0\x9F\x8C\x86\xF0\x9F\x8C\x87\xF0\x9F\x8C\x89\xF0\x9F\x8E\xA0\xF0\x9F\x8E\xA1\xF0\x9F\x8E\xA2\xF0\x9F\x92\x88\xF0\x9F\x8E\xAA\xF0\x9F\x9A\x82\xF0\x9F\x9A\x83\xF0\x9F\x9A\x84\xF0\x9F\x9A\x85\xF0\x9F\x9A\x86\xF0\x9F\x9A\x87\xF0\x9F\x9A\x88\xF0\x9F\x9A\x89\xF0\x9F\x9A\x8A\xF0\x9F\x9A\x9D\xF0\x9F\x9A\x9E\xF0\x9F\x9A\x8B\xF0\x9F\x9A\x8C\xF0\x9F\x9A\x8D\xF0\x9F\x9A\x8E\xF0\x9F\x9A\x90\xF0\x9F\x9A\x91\xF0\x9F\x9A\x92\xF0\x9F\x9A\x93\xF0\x9F\x9A\x94\xF0\x9F\x9A\x95\xF0\x9F\x9A\x96\xF0\x9F\x9A\x97\xF0\x9F\x9A\x98\xF0\x9F\x9A\x99\xF0\x9F\x9B\xBB\xF0\x9F\x9A\x9A\xF0\x9F\x9A\x9B\xF0\x9F\x9A\x9C\xF0\x9F\x9B\xB5\xF0\x9F\xA6\xBD\xF0\x9F\xA6\xBC\xF0\x9F\x9B\xBA\xF0\x9F\x9A\xB2\xF0\x9F\x9B\xB4\xF0\x9F\x9B\xB9\xF0\x9F\x9B\xBC\xF0\x9F\x9A\x8F\xF0\x9F\x9A\xA8\xF0\x9F\x9A\xA5\xF0\x9F\x9A\xA6\xF0\x9F\x9B\x91\xF0\x9F\x9A\xA7\xF0\x9F\x9B\xB6\xF0\x9F\x9A\xA4\xF0\x9F\x9A\xA2\xF0\x9F\x9B\xAB\xF0\x9F\x9B\xAC\xF0\x9F\xAA\x82\xF0\x9F\x92\xBA\xF0\x9F\x9A\x81\xF0\x9F\x9A\x9F\xF0\x9F\x9A\xA0\xF0\x9F\x9A\xA1\xF0\x9F\x9A\x80\xF0\x9F\x9B\xB8\xF0\x9F\xA7\xB3\xF0\x9F\x95\x9B\xF0\x9F\x95\xA7\xF0\x9F\x95\x90\xF0\x9F\x95\x9C\xF0\x9F\x95\x91\xF0\x9F\x95\x9D\xF0\x9F\x95\x92\xF0\x9F\x95\x9E\xF0\x9F\x95\x93\xF0\x9F\x95\x9F\xF0\x9F\x95\x94\xF0\x9F\x95\xA0\xF0\x9F\x95\x95\xF0\x9F\x95\xA1\xF0\x9F\x95\x96\xF0\x9F\x95\xA2\xF0\x9F\x95\x97\xF0\x9F\x95\xA3\xF0\x9F\x95\x98\xF0\x9F\x95\xA4\xF0\x9F\x95\x99\xF0\x9F\x95\xA5\xF0\x9F\x95\x9A\xF0\x9F\x95\xA6\xF0\x9F\x8C\x91\xF0\x9F\x8C\x92\xF0\x9F\x8C\x93\xF0\x9F\x8C\x94\xF0\x9F\x8C\x95\xF0\x9F\x8C\x96\xF0\x9F\x8C\x97\xF0\x9F\x8C\x98\xF0\x9F\x8C\x99\xF0\x9F\x8C\x9A\xF0\x9F\x8C\x9B\xF0\x9F\x8C\x9C\xF0\x9F\x8C\x9D\xF0\x9F\x8C\x9E\xF0\x9F\xAA\x90\xF0\x9F\x8C\x9F\xF0\x9F\x8C\xA0\xF0\x9F\x8C\x8C\xF0\x9F\x8C\x80\xF0\x9F\x8C\x88\xF0\x9F\x8C\x82\xF0\x9F\x94\xA5\xF0\x9F\x92\xA7\xF0\x9F\x8C\x8A";
    bytes internal constant NEW_LINE = "\x25\x30\x41";

    // Prefix needed to create a string that represent a data uri
    bytes internal constant PREFIX = "data:text/plain;charset=utf-8,";
    uint16 internal constant EMOJI_COUNT = 948;

    uint8 internal constant EMOJI_PER_ROW = 4;
    uint8 internal constant BYTES_PER_EMOJI = 4;
    // Where 3 are the bytes for new line charater string
    uint32 internal constant ROW_SIZE = (EMOJI_PER_ROW * BYTES_PER_EMOJI) + 3;
    // Squared art plus 30 that is the prefix bytes length
    uint32 internal constant ART_SIZE = (ROW_SIZE * EMOJI_PER_ROW) + 30;

    // TODO
    function _draw(uint256 tokenId, uint256 randomNumber)
        internal
        pure
        returns (string memory)
    {
        // TODO: USE THE TOKEN ID TO COMPLETE POINT 2 OF TODO LIST ON MY PAPER

        uint256 d = _digits(randomNumber);
        // The digits must be at least X to matematically get (EMOJI_PER_ROW ** 2) random emoji composing the art from the number
        // Calculated using an inverse formula of the nth triangular number with n = d - 3 and max combination of 64
        // TODO: CALCULATE WITH A ROW OF 4 INSTEAD OF 8
        require(d >= 14);

        bytes memory art = new bytes(ART_SIZE);
        for (uint256 p = 0; p < 30; p++) {
            art[p] = PREFIX[p];
        }

        // The counter used to extract part of randomNumber value
        uint256 c = 0;
        // To avoid repeting consecutive empojis due to truncated 0 like 0100 becoming 100 and being equal to previous number
        uint256 last = 0;
        for (uint256 i = 30; i < ART_SIZE; i += BYTES_PER_EMOJI) {
            // Cut down randomNumber for next iteration and restart random numbers extraction index c
            if ((c + 4) > d) {
                // Slice down random number by 10 and set c to 0 for next random iteration on it
                randomNumber /= 10;
                c = 0;
            }

            // Extract part of randomNumber depending on n and always > EMOJI_COUNT digits
            // By elevating 10 by n i start from 10000 4th values on the right and go on 1 digit per time to the left
            uint256 a = randomNumber % (10000 * (10**c));
            // Make sure that this a is different from last one
            while (a <= last) {
                a *= 10;
            }
            // Save how it was last number to avoid repetitions
            last = a;

            // Make it in the range from 0 to the EMOJI_COUNT so that it is for sure inside the dictionary as integer
            uint256 b = a % EMOJI_COUNT;
            // Multiple by 4 so that it correctly point the starting byte of an emoji
            uint256 index = b * 4;

            bytes memory emoji = _emoji(index);
            art[i] = emoji[0];
            art[i + 1] = emoji[1];
            art[i + 2] = emoji[2];
            art[i + 3] = emoji[3];

            // Add new line char and increment size of 3 if at the end of the ROW_SIZE
            if (((i - 30) + BYTES_PER_EMOJI + 3) % ROW_SIZE == 0) {
                art[i + BYTES_PER_EMOJI] = NEW_LINE[0];
                art[i + BYTES_PER_EMOJI + 1] = NEW_LINE[1];
                art[i + BYTES_PER_EMOJI + 2] = NEW_LINE[2];
                i += 3;
            }

            // Increment extractor counter for next iteration
            c++;
        }

        string memory result = string(art);
        return result;
    }

    function _emoji(uint256 index) private pure returns (bytes memory) {
        // It must be a multiple of 4 otherwise it's not a valid emoji bytes index
        require(index % 4 == 0);

        bytes memory output = new bytes(4);
        output[0] = EMOJI_DICTIONARY[index];
        output[1] = EMOJI_DICTIONARY[index + 1];
        output[2] = EMOJI_DICTIONARY[index + 2];
        output[3] = EMOJI_DICTIONARY[index + 3];

        return output;
    }

    function _digits(uint256 number) private pure returns (uint8) {
        uint8 digits = 0;
        while (number != 0) {
            number /= 10;
            digits++;
        }
        return digits;
    }
}
