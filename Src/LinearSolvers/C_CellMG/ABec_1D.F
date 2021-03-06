#undef  BL_LANG_CC
#ifndef BL_LANG_FORT
#define BL_LANG_FORT
#endif

#include <REAL.H>

#include "ABec_F.H"
#include "ArrayLim.H"
#include "CONSTANTS.H"

c-----------------------------------------------------------------------
c      
c     LINESOLVE 
c     Apply the line solve to the state phi for the equation
c     L(phi) = alpha*a(x)*phi(x) - beta*Div(b(x)Grad(phi(x))) = rhs(x)
c     central differenced, according to the arrays of boundary
c     masks (m#) and auxiliary data (f#).
c     
c     In general, if the linear operator L=gamma*y-rho, the GS relaxation
c     is y = (R - rho)/gamma.  Near a boundary, the ghost data is filled
c     using a polynomial interpolant based on the "old" phi values, so
c     L=(gamma-delta)*y - rho + delta*yOld.   The resulting iteration is
c     
c     y = (R - delta*yOld + rho)/(gamma - delta)
c     
c     This expression is valid additionally in the interior provided
c     delta->0 there.  delta is constructed by summing all the
c     contributions to the central stencil element coming from boundary 
c     interpolants.  The f#s contain the corresponding coefficient of 
c     the interpolating polynomial.  The masks are set > 0 if the boundary 
c     value was filled with an interpolant involving the central stencil 
c     element.
c     
c-----------------------------------------------------------------------
      subroutine FORT_LINESOLVE (
     $     phi,DIMS(phi),
     $     rhs,DIMS(rhs),
     $     alpha, beta,
     $     a,  DIMS(a),
     $     bX, DIMS(bX),
     $     f0, DIMS(f0),
     $     m0, DIMS(m0),
     $     f2, DIMS(f2),
     $     m2, DIMS(m2),
     $     lo,hi,nc,
     $     h
     $     )
      REAL_T alpha, beta
      integer DIMDEC(phi)
      integer DIMDEC(rhs)
      integer DIMDEC(a)
      integer DIMDEC(bX)
      integer lo(BL_SPACEDIM), hi(BL_SPACEDIM)
      integer nc
      integer DIMDEC(f0)
      REAL_T f0(DIMV(f0))
      integer DIMDEC(f2)
      REAL_T f2(DIMV(f2))
      integer DIMDEC(m0)
      integer m0(DIMV(m0))
      integer DIMDEC(m2)
      integer m2(DIMV(m2))
      REAL_T  h(BL_SPACEDIM)
      REAL_T   phi(DIMV(phi),nc)
      REAL_T   rhs(DIMV(rhs),nc)
      REAL_T     a(DIMV(a))
      REAL_T    bX(DIMV(bX))
c
      integer  i, n
c
      REAL_T dhx, cf0, cf2
      REAL_T delta, gamma, rho, rho_x

      integer LSDIM
      parameter(LSDIM=127)
      REAL_T a_ls(0:LSDIM)
      REAL_T b_ls(0:LSDIM)
      REAL_T c_ls(0:LSDIM)
      REAL_T r_ls(0:LSDIM)
      REAL_T u_ls(0:LSDIM)

      integer ilen
      ilen = hi(1)-lo(1)+1
c
      dhx = beta/h(1)**2
      do n = 1, nc
             do i = lo(1), hi(1)
c     
               cf0 = merge(f0(lo(1)), 0.0D0,
     $              (i .eq. lo(1)) .and. (m0(lo(1)-1).gt.0))
               cf2 = merge(f2(hi(1)), 0.0D0,
     $              (i .eq. hi(1)) .and. (m2(hi(1)+1).gt.0))
c     
               delta = dhx*(bX(i)*cf0 + bX(i+1)*cf2)
c     
               gamma = alpha*a(i)
     $              +   dhx*( bX(i) + bX(i+1) )

               a_ls(i-lo(1)) = -dhx*bX(i)
               b_ls(i-lo(1)) = gamma - delta
               c_ls(i-lo(1)) = -dhx*bX(i+1)
               r_ls(i-lo(1)) = rhs(i,n) - phi(i,n)*delta

               if (i .eq. lo(1)) 
     $            r_ls(i-lo(1)) = r_ls(i-lo(1)) + dhx*bX(i)*phi(i-1,n)

               if (i .eq. hi(1)) 
     $            r_ls(i-lo(1)) = r_ls(i-lo(1)) + dhx*bX(i+1)*phi(i+1,n)
             end do

             call tridiag(a_ls,b_ls,c_ls,r_ls,u_ls,ilen)
c     
             do i = lo(1), hi(1)
               phi(i,n) = u_ls(i-lo(1))
             end do
      end do

      end

c-----------------------------------------------------------------------
c
c     Fill in a matrix x vector operator here
c
      subroutine FORT_ADOTX(
     $     y,DIMS(y),
     $     x,DIMS(x),
     $     alpha, beta,
     $     a, DIMS(a),
     $     bX, DIMS(bX),
     $     lo,hi,nc,
     $     h
     $     )
      REAL_T alpha, beta
      integer lo(BL_SPACEDIM), hi(BL_SPACEDIM), nc
      integer DIMDEC(y)
      integer DIMDEC(x)
      integer DIMDEC(a)
      integer DIMDEC(bX)
      REAL_T  x(DIMV(x),nc)
      REAL_T  y(DIMV(x),nc)
      REAL_T  a(DIMV(a))
      REAL_T bX(DIMV(bX))
      REAL_T h(BL_SPACEDIM)
c
      integer i,n
      REAL_T dhx
c
      dhx = beta/h(1)**2
c
      do n = 1, nc
         do i = lo(1), hi(1)
            y(i,n) = alpha*a(i)*x(i,n)
     $           - dhx*
     $           (   bX(i+1)*( x(i+1,n) - x(i  ,n) )
     $           -   bX(i  )*( x(i  ,n) - x(i-1,n) ) )
         end do
      end do
      end

c-----------------------------------------------------------------------
c
c     Fill in a matrix x vector operator here
c
      subroutine FORT_NORMA(
     &     res,
     $     alpha, beta,
     $     a, DIMS(a),
     $     bX,DIMS(bX),
     $     lo,hi,nc,
     $     h
     $     )
      REAL_T res
      REAL_T alpha, beta
      integer lo(BL_SPACEDIM), hi(BL_SPACEDIM), nc
      integer DIMDEC(a)
      integer DIMDEC(bX)
      REAL_T  a(DIMV(a))
      REAL_T bX(DIMV(bX))
      REAL_T h(BL_SPACEDIM)
c
      integer i,n
      REAL_T dhx
c
      dhx = beta/h(1)**2
c
      res = 0.0D0
      do n = 1, nc
         do i = lo(1), hi(1)
            res = max(res, 
     &           + abs( alpha*a(i) 
     &                + dhx * (bX(i+1) + bX(i)) )
     $           + abs(-dhx*bX(i+1)) + abs(-dhx*bX(i)) )
         end do
      end do
      end
c-----------------------------------------------------------------------
c
c     Fill in fluxes
c
      subroutine FORT_FLUX(
     $     x,DIMS(x),
     $     alpha, beta,
     $     a, DIMS(a),
     $     bX,DIMS(bX),
     $     xlo,xhi,nc,
     $     h,
     $     xflux,DIMS(xflux)
     $     )
      implicit none
      REAL_T alpha, beta
      integer xlo(BL_SPACEDIM), xhi(BL_SPACEDIM), nc
      integer DIMDEC(x)
      integer DIMDEC(a)
      integer DIMDEC(bX)
      integer DIMDEC(xflux)
      REAL_T  x(DIMV(x),nc)
      REAL_T  a(DIMV(a))
      REAL_T bX(DIMV(bX))
      REAL_T xflux(DIMV(xflux),nc)
      REAL_T h(BL_SPACEDIM)
c
      REAL_T dhx
      integer i,n
c
      dhx = one/h(1)
c
      do n = 1, nc
         do i = xlo(1), xhi(1)
            xflux(i,n) = - dhx*bX(i)*( x(i,n) - x(i-1,n) )
         end do
      end do
      end

