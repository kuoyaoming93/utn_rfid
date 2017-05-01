/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/juan/Proyecto final/utn_rfid/VERILOG/Manchester/ISE Manchester/proyecto/tb_man_mod.v";
static int ng1[] = {0, 0};
static int ng2[] = {4, 0};
static unsigned int ng3[] = {1U, 0U};
static unsigned int ng4[] = {0U, 0U};



static void Initial_43_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;

LAB0:    t1 = (t0 + 2680U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(43, ng0);

LAB4:    xsi_set_current_line(45, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1448);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(46, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1608);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(47, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 1768);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(50, ng0);
    t2 = (t0 + 2488);
    xsi_process_wait(t2, 100000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    goto LAB1;

}

static void Always_54_1(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;

LAB0:    t1 = (t0 + 2928U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(55, ng0);
    t2 = (t0 + 2736);
    xsi_process_wait(t2, 1000LL);
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(55, ng0);
    t4 = (t0 + 1448);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memset(t3, 0, 8);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 & 1U);
    if (t12 != 0)
        goto LAB8;

LAB6:    if (*((unsigned int *)t7) == 0)
        goto LAB5;

LAB7:    t13 = (t3 + 4);
    *((unsigned int *)t3) = 1;
    *((unsigned int *)t13) = 1;

LAB8:    t14 = (t3 + 4);
    t15 = (t6 + 4);
    t16 = *((unsigned int *)t6);
    t17 = (~(t16));
    *((unsigned int *)t3) = t17;
    *((unsigned int *)t14) = 0;
    if (*((unsigned int *)t15) != 0)
        goto LAB10;

LAB9:    t22 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t22 & 1U);
    t23 = *((unsigned int *)t14);
    *((unsigned int *)t14) = (t23 & 1U);
    t24 = (t0 + 1448);
    xsi_vlogvar_assign_value(t24, t3, 0, 0, 1);
    goto LAB2;

LAB5:    *((unsigned int *)t3) = 1;
    goto LAB8;

LAB10:    t18 = *((unsigned int *)t3);
    t19 = *((unsigned int *)t15);
    *((unsigned int *)t3) = (t18 | t19);
    t20 = *((unsigned int *)t14);
    t21 = *((unsigned int *)t15);
    *((unsigned int *)t14) = (t20 | t21);
    goto LAB9;

}

static void Initial_57_2(char *t0)
{
    char t12[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    unsigned int t5;
    unsigned int t6;
    unsigned int t7;
    int t8;
    char *t9;
    char *t10;
    char *t11;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    char *t22;
    char *t23;
    char *t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    char *t33;

LAB0:    t1 = (t0 + 3176U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(58, ng0);

LAB4:    xsi_set_current_line(60, ng0);
    t2 = (t0 + 2984);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(60, ng0);
    t3 = ((char*)((ng2)));
    t4 = (t3 + 4);
    t5 = *((unsigned int *)t4);
    t6 = (~(t5));
    t7 = *((unsigned int *)t3);
    t8 = (t7 & t6);
    t9 = (t0 + 5120);
    *((int *)t9) = t8;

LAB6:    t10 = (t0 + 5120);
    if (*((int *)t10) > 0)
        goto LAB7;

LAB8:    xsi_set_current_line(61, ng0);
    t2 = (t0 + 2984);
    xsi_process_wait(t2, 36000LL);
    *((char **)t1) = &&LAB16;
    goto LAB1;

LAB7:    xsi_set_current_line(60, ng0);
    t11 = (t0 + 2984);
    xsi_process_wait(t11, 8000LL);
    *((char **)t1) = &&LAB9;
    goto LAB1;

LAB9:    xsi_set_current_line(60, ng0);
    t13 = (t0 + 1768);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memset(t12, 0, 8);
    t16 = (t15 + 4);
    t17 = *((unsigned int *)t16);
    t18 = (~(t17));
    t19 = *((unsigned int *)t15);
    t20 = (t19 & t18);
    t21 = (t20 & 1U);
    if (t21 != 0)
        goto LAB13;

LAB11:    if (*((unsigned int *)t16) == 0)
        goto LAB10;

LAB12:    t22 = (t12 + 4);
    *((unsigned int *)t12) = 1;
    *((unsigned int *)t22) = 1;

LAB13:    t23 = (t12 + 4);
    t24 = (t15 + 4);
    t25 = *((unsigned int *)t15);
    t26 = (~(t25));
    *((unsigned int *)t12) = t26;
    *((unsigned int *)t23) = 0;
    if (*((unsigned int *)t24) != 0)
        goto LAB15;

LAB14:    t31 = *((unsigned int *)t12);
    *((unsigned int *)t12) = (t31 & 1U);
    t32 = *((unsigned int *)t23);
    *((unsigned int *)t23) = (t32 & 1U);
    t33 = (t0 + 1768);
    xsi_vlogvar_assign_value(t33, t12, 0, 0, 1);
    t2 = (t0 + 5120);
    t8 = *((int *)t2);
    *((int *)t2) = (t8 - 1);
    goto LAB6;

LAB10:    *((unsigned int *)t12) = 1;
    goto LAB13;

LAB15:    t27 = *((unsigned int *)t12);
    t28 = *((unsigned int *)t24);
    *((unsigned int *)t12) = (t27 | t28);
    t29 = *((unsigned int *)t23);
    t30 = *((unsigned int *)t24);
    *((unsigned int *)t23) = (t29 | t30);
    goto LAB14;

LAB16:    xsi_set_current_line(61, ng0);
    t3 = ((char*)((ng3)));
    t4 = (t0 + 1608);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 1);
    xsi_set_current_line(62, ng0);
    t2 = (t0 + 2984);
    xsi_process_wait(t2, 16000LL);
    *((char **)t1) = &&LAB17;
    goto LAB1;

LAB17:    xsi_set_current_line(62, ng0);
    t3 = ((char*)((ng2)));
    t4 = (t3 + 4);
    t5 = *((unsigned int *)t4);
    t6 = (~(t5));
    t7 = *((unsigned int *)t3);
    t8 = (t7 & t6);
    t9 = (t0 + 5124);
    *((int *)t9) = t8;

LAB18:    t10 = (t0 + 5124);
    if (*((int *)t10) > 0)
        goto LAB19;

LAB20:    xsi_set_current_line(63, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 1768);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(64, ng0);
    t2 = (t0 + 2984);
    xsi_process_wait(t2, 16000LL);
    *((char **)t1) = &&LAB28;
    goto LAB1;

LAB19:    xsi_set_current_line(62, ng0);
    t11 = (t0 + 2984);
    xsi_process_wait(t11, 16000LL);
    *((char **)t1) = &&LAB21;
    goto LAB1;

LAB21:    xsi_set_current_line(62, ng0);
    t13 = (t0 + 1768);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    memset(t12, 0, 8);
    t16 = (t15 + 4);
    t17 = *((unsigned int *)t16);
    t18 = (~(t17));
    t19 = *((unsigned int *)t15);
    t20 = (t19 & t18);
    t21 = (t20 & 1U);
    if (t21 != 0)
        goto LAB25;

LAB23:    if (*((unsigned int *)t16) == 0)
        goto LAB22;

LAB24:    t22 = (t12 + 4);
    *((unsigned int *)t12) = 1;
    *((unsigned int *)t22) = 1;

LAB25:    t23 = (t12 + 4);
    t24 = (t15 + 4);
    t25 = *((unsigned int *)t15);
    t26 = (~(t25));
    *((unsigned int *)t12) = t26;
    *((unsigned int *)t23) = 0;
    if (*((unsigned int *)t24) != 0)
        goto LAB27;

LAB26:    t31 = *((unsigned int *)t12);
    *((unsigned int *)t12) = (t31 & 1U);
    t32 = *((unsigned int *)t23);
    *((unsigned int *)t23) = (t32 & 1U);
    t33 = (t0 + 1768);
    xsi_vlogvar_assign_value(t33, t12, 0, 0, 1);
    t2 = (t0 + 5124);
    t8 = *((int *)t2);
    *((int *)t2) = (t8 - 1);
    goto LAB18;

LAB22:    *((unsigned int *)t12) = 1;
    goto LAB25;

LAB27:    t27 = *((unsigned int *)t12);
    t28 = *((unsigned int *)t24);
    *((unsigned int *)t12) = (t27 | t28);
    t29 = *((unsigned int *)t23);
    t30 = *((unsigned int *)t24);
    *((unsigned int *)t23) = (t29 | t30);
    goto LAB26;

LAB28:    xsi_set_current_line(64, ng0);
    t3 = ((char*)((ng3)));
    t4 = (t0 + 1768);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 1);
    xsi_set_current_line(69, ng0);
    t2 = (t0 + 2984);
    xsi_process_wait(t2, 26000LL);
    *((char **)t1) = &&LAB29;
    goto LAB1;

LAB29:    xsi_set_current_line(69, ng0);
    t3 = ((char*)((ng4)));
    t4 = (t0 + 1608);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 1);
    xsi_set_current_line(70, ng0);
    t2 = (t0 + 2984);
    xsi_process_wait(t2, 4000LL);
    *((char **)t1) = &&LAB30;
    goto LAB1;

LAB30:    xsi_set_current_line(70, ng0);
    t3 = ((char*)((ng3)));
    t4 = (t0 + 1608);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 1);
    xsi_set_current_line(71, ng0);
    t2 = (t0 + 2984);
    xsi_process_wait(t2, 40000LL);
    *((char **)t1) = &&LAB31;
    goto LAB1;

LAB31:    xsi_set_current_line(71, ng0);
    xsi_vlog_finish(1);
    goto LAB1;

}


extern void work_m_06024276275895280477_1644384315_init()
{
	static char *pe[] = {(void *)Initial_43_0,(void *)Always_54_1,(void *)Initial_57_2};
	xsi_register_didat("work_m_06024276275895280477_1644384315", "isim/tb_man_mod_isim_beh.exe.sim/work/m_06024276275895280477_1644384315.didat");
	xsi_register_executes(pe);
}
