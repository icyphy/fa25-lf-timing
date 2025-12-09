; ModuleID = '/home/gametime/test/lf-gametime-TCP2/driver_analysis/drivergt/drivergt_linked_inlined_mod.ll'
source_filename = "/home/gametime/test/lf-gametime-TCP2/driver_analysis/driver.c"
target datalayout = "e-m:e-i8:8:32-i16:16:32-i64:64-i128:128-n32:64-S128"
target triple = "aarch64-unknown-linux-gnu"

@schedule_count = dso_local global i32 0, align 4
@refresh = dso_local global i64 20000000, align 8
@period = dso_local global i64 1000000000, align 8
@id = dso_local global i32 0, align 4

; Function Attrs: noinline nounwind uwtable
define dso_local void @TCP2_tick() #0 {
  ret void
}

attributes #0 = { noinline nounwind uwtable "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+fp-armv8,+neon,+outline-atomics,+v8a,-fmv" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 1}
!5 = !{!"Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)"}