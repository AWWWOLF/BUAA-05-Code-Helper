/*
 * zengwen_data.c
 *
 * Code generation for model "zengwen".
 *
 * Model version              : 1.4
 * Simulink Coder version : 8.14 (R2018a) 06-Feb-2018
 * C source code generated on : Sat Jun 24 20:26:28 2023
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "zengwen.h"
#include "zengwen_private.h"

/* Block parameters (default storage) */
P_zengwen_T zengwen_P = {
  /* Variable: A_LAT
   * Referenced by: '<Root>/LAT'
   */
  { -0.24205846525094515, -21.892814114574747, 7.918206820841017, 0.0,
    0.052356020942408377, -4.1499612673157369, 0.12254513553495035, 1.0, -1.0,
    1.5803696103626295, -0.4829616074239787, 0.052403912073911034,
    0.074366044213918681, 0.0, 0.0, 0.0 },

  /* Variable: A_LON
   * Referenced by: '<Root>/LON'
   */
  { -0.01571079514841554, -0.0011571618007164507, 0.00025063987286129543, 0.0,
    2.731471172522915, -1.3591896799038066, 3.7305979458628666, 0.0, 0.0, 1.0,
    -0.83128471644787427, 1.0, -9.8, 0.0, 0.0, 0.0 },

  /* Variable: B_LAT
   * Referenced by: '<Root>/LAT'
   */
  { 0.0, -58.890032321854733, 1.1022667933412487, 0.0, 0.075580146660413322,
    9.1258781507799682, -6.52558755790902, 0.0 },

  /* Variable: B_LON
   * Referenced by: '<Root>/LON'
   */
  { -0.0, -0.11059277584831083, -12.939106743071951, 0.0, 0.834622207513941,
    -0.0003323515864551223, 7.19869592331743E-5, 0.0 },

  /* Variable: C
   * Referenced by:
   *   '<Root>/LAT'
   *   '<Root>/LON'
   */
  { 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0,
    1.0 },

  /* Variable: ini_state_LON
   * Referenced by:
   *   '<Root>/LAT'
   *   '<Root>/LON'
   */
  { 0.0, 0.0, 0.0, 0.0 },

  /* Expression: 0.391
   * Referenced by: '<Root>/k_alpha'
   */
  0.391,

  /* Expression: 0.01
   * Referenced by: '<Root>/de'
   */
  0.01,

  /* Expression: 0
   * Referenced by: '<Root>/de'
   */
  0.0,

  /* Expression: 1
   * Referenced by: '<Root>/de'
   */
  1.0,

  /* Expression: 1
   * Referenced by: '<Root>/Gain'
   */
  1.0,

  /* Expression: 0.01
   * Referenced by: '<Root>/dp'
   */
  0.01,

  /* Expression: 0
   * Referenced by: '<Root>/dp'
   */
  0.0,

  /* Expression: 1
   * Referenced by: '<Root>/dp'
   */
  1.0,

  /* Expression: 0
   * Referenced by: '<Root>/Gain1'
   */
  0.0,

  /* Expression: 0.01
   * Referenced by: '<Root>/da'
   */
  0.01,

  /* Expression: 0
   * Referenced by: '<Root>/da'
   */
  0.0,

  /* Expression: 1
   * Referenced by: '<Root>/da'
   */
  1.0,

  /* Expression: 0
   * Referenced by: '<Root>/Gain2'
   */
  0.0,

  /* Expression: 0.01
   * Referenced by: '<Root>/dr'
   */
  0.01,

  /* Expression: 0
   * Referenced by: '<Root>/dr'
   */
  0.0,

  /* Expression: 1
   * Referenced by: '<Root>/dr'
   */
  1.0,

  /* Expression: 0
   * Referenced by: '<Root>/Gain3'
   */
  0.0
};
